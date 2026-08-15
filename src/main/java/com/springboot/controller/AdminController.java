package com.springboot.controller;

import com.springboot.dto.GameRequest;
import com.springboot.model.Game;
import com.springboot.model.GamePackage;
import com.springboot.model.TopUpOrder;
import com.springboot.model.User;
import com.springboot.service.GameService;
import com.springboot.service.SupportService;
import com.springboot.service.GamePackageService;
import com.springboot.service.TopUpOrderService;
import com.springboot.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    private final UserService userService;
    private final GameService gameService;
    private final GamePackageService packageService;
    private final TopUpOrderService orderService;
    private final SupportService supportService;
    
    public AdminController(UserService userService, GameService gameService, 
                          GamePackageService packageService, TopUpOrderService orderService, SupportService supportService) {
        this.userService = userService;
        this.gameService = gameService;
        this.packageService = packageService;
        this.orderService = orderService;
        this.supportService = supportService;		;
    }
    
    /**
     * Check if user is admin
     */
    private boolean isAdmin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        return user != null && "admin".equals(user.getRole());
    }
    
    /**
     * Admin Dashboard
     */
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        User admin = (User) session.getAttribute("user");
        
        // Get statistics
        long totalUsers = userService.countAllUsers();
        long totalGames = gameService.countAllGames();
        long totalOrders = orderService.getAllOrders().size();
        long pendingOrders = orderService.getPendingOrdersCount();
        long processingOrders = orderService.getProcessingOrdersCount();
        long completedOrders = orderService.getCompletedOrdersCount();
        Double totalRevenue = orderService.getTotalRevenue();
        
        // Get recent orders
        List<TopUpOrder> recentOrders = orderService.getRecentOrders();
        
        model.addAttribute("user", admin);
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalGames", totalGames);
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("pendingOrders", pendingOrders);
        model.addAttribute("processingOrders", processingOrders);
        model.addAttribute("completedOrders", completedOrders);
        model.addAttribute("totalRevenue", totalRevenue);
        model.addAttribute("recentOrders", recentOrders);
        
        return "admin-dashboard";
    }
    
    /**
     * Manage Games
     */
    @GetMapping("/games")
    public String manageGames(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        User admin = (User) session.getAttribute("user");
        List<Game> games = gameService.getAllGames();
        
        model.addAttribute("user", admin);
        model.addAttribute("games", games);
        model.addAttribute("gameRequest", new GameRequest());
        
        return "admin-games";
    }
    
    /**
     * Add new game
     */
    @PostMapping("/games/add")
    public String addGame(@ModelAttribute GameRequest gameRequest,
                         HttpSession session,
                         RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        if (!gameRequest.isValid()) {
            redirectAttributes.addFlashAttribute("error", "Please fill in all required fields");
            return "redirect:/admin/games";
        }
        
        Game game = new Game();
        game.setName(gameRequest.getName());
        game.setDescription(gameRequest.getDescription());
        game.setCategories(gameRequest.getCategory()); // This will be comma-separated
        game.setImageUrl(gameRequest.getImageUrl());
        game.setActive(gameRequest.getActive() != null ? gameRequest.getActive() : true);
        game.setPopular(gameRequest.getPopular() != null ? gameRequest.getPopular() : false);
        
        gameService.createGame(game);
        
        redirectAttributes.addFlashAttribute("success", "Game added successfully!");
        return "redirect:/admin/games";
    }
    
    /**
     * Toggle game active status
     */
    @PostMapping("/games/toggle-active/{gameId}")
    public String toggleGameActive(@PathVariable Long gameId,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        gameService.toggleGameActive(gameId);
        redirectAttributes.addFlashAttribute("success", "Game status updated!");
        return "redirect:/admin/games";
    }
    
    /**
     * Toggle game popular status
     */
    @PostMapping("/games/toggle-popular/{gameId}")
    public String toggleGamePopular(@PathVariable Long gameId,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        gameService.toggleGamePopular(gameId);
        redirectAttributes.addFlashAttribute("success", "Game popularity updated!");
        return "redirect:/admin/games";
    }
    
    /**
     * Delete game
     */
    @PostMapping("/games/delete/{gameId}")
    public String deleteGame(@PathVariable Long gameId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        gameService.deleteGame(gameId);
        redirectAttributes.addFlashAttribute("success", "Game deleted successfully!");
        return "redirect:/admin/games";
    }
    
    /**
     * Manage Orders
     */
    @GetMapping("/orders")
    public String manageOrders(@RequestParam(required = false) String status,
                              HttpSession session,
                              Model model,
                              RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        User admin = (User) session.getAttribute("user");
        
        List<TopUpOrder> orders;
        if (status != null && !status.trim().isEmpty()) {
            orders = orderService.getOrdersByStatus(status);
            model.addAttribute("selectedStatus", status);
        } else {
            orders = orderService.getAllOrders();
        }
        
        model.addAttribute("user", admin);
        model.addAttribute("orders", orders);
        
        return "admin-orders";
    }
    
    /**
     * Update order status
     */
    @PostMapping("/orders/update-status/{orderId}")
    public String updateOrderStatus(@PathVariable Long orderId,
                                   @RequestParam String status,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        orderService.updateOrderStatus(orderId, status);
        redirectAttributes.addFlashAttribute("success", "Order status updated to: " + status);
        return "redirect:/admin/orders";
    }
    
    /**
     * Manage Users
     */
    @GetMapping("/users")
    public String manageUsers(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        User admin = (User) session.getAttribute("user");
        List<User> users = userService.getAllUsers();
        
        model.addAttribute("user", admin);
        model.addAttribute("users", users);
        
        return "admin-users";
    }
    
    /**
     * Toggle user active status
     */
    @PostMapping("/users/toggle-active/{userId}")
    public String toggleUserActive(@PathVariable Long userId,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        userService.toggleUserActive(userId);
        redirectAttributes.addFlashAttribute("success", "User status updated!");
        return "redirect:/admin/users";
    }
    
    /**
     * Manage game packages
     */
    @GetMapping("/games/{gameId}/packages")
    public String managePackages(@PathVariable Long gameId,
                                 HttpSession session,
                                 Model model,
                                 RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        Optional<Game> gameOpt = gameService.getGameById(gameId);
        if (gameOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Game not found");
            return "redirect:/admin/games";
        }
        
        Game game = gameOpt.get();
        List<GamePackage> packages = packageService.getPackagesByGameId(gameId);
        
        User admin = (User) session.getAttribute("user");
        model.addAttribute("user", admin);
        model.addAttribute("game", game);
        model.addAttribute("packages", packages);
        
        return "admin-packages";
    }
    
    /**
     * Add package to game
     */
    @PostMapping("/games/{gameId}/packages/add")
    public String addPackage(@PathVariable Long gameId,
                            @RequestParam String name,
                            @RequestParam Double price,
                            @RequestParam(required = false) String description,
                            @RequestParam(required = false) String imageUrl,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        Optional<Game> gameOpt = gameService.getGameById(gameId);
        if (gameOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Game not found");
            return "redirect:/admin/games";
        }
        
        GamePackage gamePackage = new GamePackage();
        gamePackage.setGame(gameOpt.get());
        gamePackage.setName(name);
        gamePackage.setPrice(price);
        gamePackage.setDescription(description);
        gamePackage.setImageUrl(imageUrl);
        gamePackage.setActive(true);
        
        packageService.createPackage(gamePackage);
        
        redirectAttributes.addFlashAttribute("success", "Package added successfully!");
        return "redirect:/admin/games/" + gameId + "/packages";
    }
    
    /**
     * Edit package
     */
    @PostMapping("/packages/edit/{packageId}")
    public String editPackage(@PathVariable Long packageId,
                             @RequestParam String name,
                             @RequestParam Double price,
                             @RequestParam(required = false) String description,
                             @RequestParam(required = false) String imageUrl,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        Optional<GamePackage> packageOpt = packageService.getPackageById(packageId);
        if (packageOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Package not found");
            return "redirect:/admin/games";
        }
        
        GamePackage gamePackage = packageOpt.get();
        gamePackage.setName(name);
        gamePackage.setPrice(price);
        gamePackage.setDescription(description);
        gamePackage.setImageUrl(imageUrl);
        
        packageService.updatePackage(gamePackage);
        
        redirectAttributes.addFlashAttribute("success", "Package updated successfully!");
        return "redirect:/admin/games/" + gamePackage.getGame().getId() + "/packages";
    }
    
    /**
     * Toggle package active status
     */
    @PostMapping("/packages/toggle-active/{packageId}")
    public String togglePackageActive(@PathVariable Long packageId,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        Optional<GamePackage> packageOpt = packageService.getPackageById(packageId);
        if (packageOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Package not found");
            return "redirect:/admin/games";
        }
        
        packageService.togglePackageActive(packageId);
        redirectAttributes.addFlashAttribute("success", "Package status updated!");
        
        return "redirect:/admin/games/" + packageOpt.get().getGame().getId() + "/packages";
    }
    
    /**
     * Delete package
     */
    @PostMapping("/packages/delete/{packageId}")
    public String deletePackage(@PathVariable Long packageId,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        Optional<GamePackage> packageOpt = packageService.getPackageById(packageId);
        if (packageOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Package not found");
            return "redirect:/admin/games";
        }
        
        Long gameId = packageOpt.get().getGame().getId();
        packageService.deletePackage(packageId);
        
        redirectAttributes.addFlashAttribute("success", "Package deleted successfully!");
        return "redirect:/admin/games/" + gameId + "/packages";
    }
    
    /**
     * Update game
     */
    @PostMapping("/games/edit/{gameId}")
    public String updateGame(@PathVariable Long gameId,
                            @ModelAttribute GameRequest gameRequest,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        Optional<Game> gameOpt = gameService.getGameById(gameId);
        if (gameOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Game not found");
            return "redirect:/admin/games";
        }
        
        Game game = gameOpt.get();
        game.setName(gameRequest.getName());
        game.setDescription(gameRequest.getDescription());
        game.setCategories(gameRequest.getCategory());
        game.setImageUrl(gameRequest.getImageUrl());
        
        if (gameRequest.getActive() != null) {
            game.setActive(gameRequest.getActive());
        }
        if (gameRequest.getPopular() != null) {
            game.setPopular(gameRequest.getPopular());
        }
        
        gameService.updateGame(game);
        
        redirectAttributes.addFlashAttribute("success", "Game updated successfully!");
        return "redirect:/admin/games";
    }
    
    /**
     * Add balance to user
     */
    @PostMapping("/users/add-balance/{userId}")
    public String addBalanceToUser(@PathVariable Long userId,
                                  @RequestParam Double amount,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        
        if (!isAdmin(session)) {
            redirectAttributes.addFlashAttribute("error", "Access denied. Admin only.");
            return "redirect:/home";
        }
        
        if (amount <= 0) {
            redirectAttributes.addFlashAttribute("error", "Amount must be greater than 0");
            return "redirect:/admin/users";
        }
        
        User user = userService.addBalance(userId, amount);
        if (user != null) {
            redirectAttributes.addFlashAttribute("success", "Balance added successfully!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to add balance");
        }
        
        return "redirect:/admin/users";
    }
    
    @GetMapping("/admin-report")
    public String adminReport(Model model) {
        model.addAttribute("tickets", supportService.findAll());
        return "admin-report"; // ไป JSP ด้านล่าง
    }
}