package com.springboot.service;

import com.springboot.model.Game;
import com.springboot.model.GamePackage;
import com.springboot.model.TopUpOrder;
import com.springboot.model.User;
import com.springboot.repository.TopUpOrderRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class TopUpOrderService {
    
    private final TopUpOrderRepository topUpOrderRepository;
    private final UserService userService;
    private final GameService gameService;
    private final GamePackageService packageService;
    
    public TopUpOrderService(TopUpOrderRepository topUpOrderRepository, UserService userService, 
                            GameService gameService, GamePackageService packageService) {
        this.topUpOrderRepository = topUpOrderRepository;
        this.userService = userService;
        this.gameService = gameService;
        this.packageService = packageService;
    }
    
    /**
     * Get all orders
     */
    public List<TopUpOrder> getAllOrders() {
        return topUpOrderRepository.findAllByOrderByCreatedAtDesc();
    }
    
    /**
     * Get order by ID
     */
    public Optional<TopUpOrder> getOrderById(Long id) {
        return topUpOrderRepository.findById(id);
    }
    
    /**
     * Get orders by user
     */
    public List<TopUpOrder> getOrdersByUser(User user) {
        return topUpOrderRepository.findByUserOrderByCreatedAtDesc(user);
    }
    
    /**
     * Get orders by user ID
     */
    public List<TopUpOrder> getOrdersByUserId(Long userId) {
        Optional<User> userOpt = userService.getUserById(userId);
        return userOpt.map(user -> topUpOrderRepository.findByUserOrderByCreatedAtDesc(user))
                .orElse(List.of());
    }
    
    /**
     * Get orders by status
     */
    public List<TopUpOrder> getOrdersByStatus(String status) {
        return topUpOrderRepository.findByStatusOrderByCreatedAtDesc(status);
    }
    
    /**
     * Get orders by user and status
     */
    public List<TopUpOrder> getOrdersByUserAndStatus(User user, String status) {
        return topUpOrderRepository.findByUserAndStatusOrderByCreatedAtDesc(user, status);
    }
    
    /**
     * Create new order
     */
    public TopUpOrder createOrder(TopUpOrder order) {
        // Set default status
        if (order.getStatus() == null || order.getStatus().isEmpty()) {
            order.setStatus("pending");
        }
        
        // Increment game order count
        if (order.getGame() != null) {
            gameService.incrementOrderCount(order.getGame().getId());
        }
        
        return topUpOrderRepository.save(order);
    }
    
    /**
     * Create order and deduct balance
     */
    public TopUpOrder createOrderWithPayment(Long userId, Long gameId, Long packageId,
                                              String packageName, Double amount, 
                                              String gameUserId, String gameServerName) {
        // Check if user has sufficient balance
        if (!userService.hasSufficientBalance(userId, amount)) {
            return null;
        }
        
        Optional<User> userOpt = userService.getUserById(userId);
        Optional<Game> gameOpt = gameService.getGameById(gameId);
        
        if (userOpt.isPresent() && gameOpt.isPresent()) {
            User user = userOpt.get();
            Game game = gameOpt.get();
            
            // Deduct balance
            User updatedUser = userService.deductBalance(userId, amount);
            if (updatedUser == null) {
                return null;
            }
            
            // Create order
            TopUpOrder order = new TopUpOrder();
            order.setUser(user);
            order.setGame(game);
            order.setPackageName(packageName);
            order.setAmount(amount);
            order.setGameUserId(gameUserId);
            order.setGameServerName(gameServerName);
            order.setStatus("pending");
            
            // Save order first
            TopUpOrder savedOrder = createOrder(order);
            
            // Increment package order count using packageId directly
            if (packageId != null) {
                packageService.incrementOrderCount(packageId);
                System.out.println("✅ Package Order Count Incremented! Package ID: " + packageId);
            } else {
                System.out.println("⚠️ Warning: packageId is null, order count not incremented");
            }
            
            return savedOrder;
        }
        
        return null;
    }
    
    /**
     * Increment package order count by game ID and package name (Deprecated - use packageId instead)
     */
    @Deprecated
    private void incrementPackageOrderCount(Long gameId, String packageName) {
        List<GamePackage> packages = packageService.getPackagesByGameId(gameId);
        for (GamePackage pkg : packages) {
            if (pkg.getName().equals(packageName)) {
                packageService.incrementOrderCount(pkg.getId());
                break;
            }
        }
    }
    
    /**
     * Update order
     */
    public TopUpOrder updateOrder(TopUpOrder order) {
        return topUpOrderRepository.save(order);
    }
    
    /**
     * Update order status
     */
    public TopUpOrder updateOrderStatus(Long orderId, String status) {
        Optional<TopUpOrder> orderOpt = topUpOrderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            TopUpOrder order = orderOpt.get();
            order.setStatus(status);
            
            // Set completed date if status is completed
            if ("completed".equals(status)) {
                order.setCompletedAt(LocalDateTime.now());
            }
            
            return topUpOrderRepository.save(order);
        }
        return null;
    }
    
    /**
     * Cancel order and refund
     */
    public boolean cancelOrder(Long orderId) {
        Optional<TopUpOrder> orderOpt = topUpOrderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            TopUpOrder order = orderOpt.get();
            
            // Only cancel if status is pending
            if ("pending".equals(order.getStatus())) {
                // Refund balance to user
                userService.addBalance(order.getUser().getId(), order.getAmount());
                
                // Update order status
                order.setStatus("cancelled");
                topUpOrderRepository.save(order);
                
                return true;
            }
        }
        return false;
    }
    
    /**
     * Delete order
     */
    public void deleteOrder(Long id) {
        topUpOrderRepository.deleteById(id);
    }
    
    /**
     * Count orders by status
     */
    public long countOrdersByStatus(String status) {
        return topUpOrderRepository.countByStatus(status);
    }
    
    /**
     * Count orders by user
     */
    public long countOrdersByUser(User user) {
        return topUpOrderRepository.countByUser(user);
    }
    
    /**
     * Get total revenue
     */
    public Double getTotalRevenue() {
        Double revenue = topUpOrderRepository.getTotalRevenue();
        return revenue != null ? revenue : 0.0;
    }
    
    /**
     * Get total revenue by user
     */
    public Double getTotalRevenueByUser(User user) {
        Double revenue = topUpOrderRepository.getTotalRevenueByUser(user);
        return revenue != null ? revenue : 0.0;
    }
    
    /**
     * Get pending orders count
     */
    public long getPendingOrdersCount() {
        return topUpOrderRepository.countByStatus("pending");
    }
    
    /**
     * Get processing orders count
     */
    public long getProcessingOrdersCount() {
        return topUpOrderRepository.countByStatus("processing");
    }
    
    /**
     * Get completed orders count
     */
    public long getCompletedOrdersCount() {
        return topUpOrderRepository.countByStatus("completed");
    }
    
    /**
     * Get orders by date range
     */
    public List<TopUpOrder> getOrdersByDateRange(LocalDateTime start, LocalDateTime end) {
        return topUpOrderRepository.findByCreatedAtBetween(start, end);
    }
    
    /**
     * Get today's orders
     */
    public List<TopUpOrder> getTodayOrders() {
        LocalDateTime startOfDay = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0);
        LocalDateTime endOfDay = LocalDateTime.now().withHour(23).withMinute(59).withSecond(59);
        return topUpOrderRepository.findByCreatedAtBetween(startOfDay, endOfDay);
    }
    
    /**
     * Get recent orders (last 10)
     */
    public List<TopUpOrder> getRecentOrders() {
        List<TopUpOrder> allOrders = topUpOrderRepository.findAllByOrderByCreatedAtDesc();
        return allOrders.size() > 10 ? allOrders.subList(0, 10) : allOrders;
    }
}