package com.springboot.repository;

import com.springboot.model.TopUpOrder;
import com.springboot.model.User;
import com.springboot.model.Game;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface TopUpOrderRepository extends JpaRepository<TopUpOrder, Long> {
    
    /**
     * Find orders by user
     */
    List<TopUpOrder> findByUser(User user);
    
    /**
     * Find orders by user ordered by created date desc
     */
    List<TopUpOrder> findByUserOrderByCreatedAtDesc(User user);
    
    /**
     * Find orders by game
     */
    List<TopUpOrder> findByGame(Game game);
    
    /**
     * Find orders by status
     */
    List<TopUpOrder> findByStatus(String status);
    
    /**
     * Find orders by status ordered by created date desc
     */
    List<TopUpOrder> findByStatusOrderByCreatedAtDesc(String status);
    
    /**
     * Find orders by user and status
     */
    List<TopUpOrder> findByUserAndStatus(User user, String status);
    
    /**
     * Find orders by user and status ordered by created date desc
     */
    List<TopUpOrder> findByUserAndStatusOrderByCreatedAtDesc(User user, String status);
    
    /**
     * Find all orders ordered by created date desc
     */
    List<TopUpOrder> findAllByOrderByCreatedAtDesc();
    
    /**
     * Find orders created between dates
     */
    List<TopUpOrder> findByCreatedAtBetween(LocalDateTime start, LocalDateTime end);
    
    /**
     * Find orders by user created between dates
     */
    List<TopUpOrder> findByUserAndCreatedAtBetween(User user, LocalDateTime start, LocalDateTime end);
    
    /**
     * Count orders by status
     */
    long countByStatus(String status);
    
    /**
     * Count orders by user
     */
    long countByUser(User user);
    
    /**
     * Count orders by user and status
     */
    long countByUserAndStatus(User user, String status);
    
    /**
     * Get total revenue (sum of all completed orders)
     */
    @Query("SELECT SUM(o.amount) FROM TopUpOrder o WHERE o.status = 'completed'")
    Double getTotalRevenue();
    
    /**
     * Get total revenue by user
     */
    @Query("SELECT SUM(o.amount) FROM TopUpOrder o WHERE o.user = :user AND o.status = 'completed'")
    Double getTotalRevenueByUser(User user);
    
    /**
     * Get total revenue by game
     */
    @Query("SELECT SUM(o.amount) FROM TopUpOrder o WHERE o.game = :game AND o.status = 'completed'")
    Double getTotalRevenueByGame(Game game);
}