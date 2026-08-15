package com.springboot.repository;

import com.springboot.model.Game;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GameRepository extends JpaRepository<Game, Long> {
    
    /**
     * Find all active games
     */
    List<Game> findByActive(Boolean active);
    
    /**
     * Find all popular games
     */
    List<Game> findByPopular(Boolean popular);
    
    /**
     * Find popular and active games
     */
    List<Game> findByPopularAndActive(Boolean popular, Boolean active);
    
    /**
     * Find games by name containing (search)
     */
    List<Game> findByNameContainingIgnoreCase(String name);
    
    /**
     * Find active games ordered by order count (most popular first)
     */
    List<Game> findByActiveOrderByOrderCountDesc(Boolean active);
    
    /**
     * Find active games ordered by created date (newest first)
     */
    List<Game> findByActiveOrderByCreatedAtDesc(Boolean active);
    
    /**
     * Count active games
     */
    long countByActive(Boolean active);
    
    /**
     * Find games by category (using LIKE for comma-separated values)
     */
    @Query("SELECT g FROM Game g WHERE g.categories LIKE %:category%")
    List<Game> findByCategory(@Param("category") String category);
    
    /**
     * Find active games by category
     */
    @Query("SELECT g FROM Game g WHERE g.active = :active AND g.categories LIKE %:category%")
    List<Game> findByActiveAndCategory(@Param("active") Boolean active, @Param("category") String category);
}