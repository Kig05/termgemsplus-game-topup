package com.springboot.repository;

import com.springboot.model.Game;
import com.springboot.model.GamePackage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GamePackageRepository extends JpaRepository<GamePackage, Long> {
    
    /**
     * Find packages by game
     */
    List<GamePackage> findByGame(Game game);
    
    /**
     * Find active packages by game
     */
    List<GamePackage> findByGameAndActive(Game game, Boolean active);
    
    /**
     * Find packages by game ID
     */
    List<GamePackage> findByGameId(Long gameId);
    
    /**
     * Find active packages by game ID
     */
    List<GamePackage> findByGameIdAndActive(Long gameId, Boolean active);
    
    /**
     * Count packages by game
     */
    long countByGame(Game game);
}