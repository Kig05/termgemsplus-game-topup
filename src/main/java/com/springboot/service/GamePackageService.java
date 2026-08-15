package com.springboot.service;

import com.springboot.model.Game;
import com.springboot.model.GamePackage;
import com.springboot.repository.GamePackageRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class GamePackageService {
    
    private final GamePackageRepository packageRepository;
    private final GameService gameService;
    
    public GamePackageService(GamePackageRepository packageRepository, GameService gameService) {
        this.packageRepository = packageRepository;
        this.gameService = gameService;
    }
    
    /**
     * Get all packages
     */
    public List<GamePackage> getAllPackages() {
        return packageRepository.findAll();
    }
    
    /**
     * Get package by ID
     */
    public Optional<GamePackage> getPackageById(Long id) {
        return packageRepository.findById(id);
    }
    
    /**
     * Get packages by game
     */
    public List<GamePackage> getPackagesByGame(Game game) {
        return packageRepository.findByGame(game);
    }
    
    /**
     * Get packages by game ID
     */
    public List<GamePackage> getPackagesByGameId(Long gameId) {
        return packageRepository.findByGameId(gameId);
    }
    
    /**
     * Get active packages by game
     */
    public List<GamePackage> getActivePackagesByGame(Game game) {
        return packageRepository.findByGameAndActive(game, true);
    }
    
    /**
     * Get active packages by game ID
     */
    public List<GamePackage> getActivePackagesByGameId(Long gameId) {
        List<GamePackage> packages = packageRepository.findByGameIdAndActive(gameId, true);
        System.out.println("GamePackageService - Fetching packages for Game ID: " + gameId);
        System.out.println("GamePackageService - Found " + packages.size() + " active packages");
        return packages;
    }
    
    /**
     * Create new package
     */
    public GamePackage createPackage(GamePackage gamePackage) {
        if (gamePackage.getActive() == null) {
            gamePackage.setActive(true);
        }
        if (gamePackage.getOrderCount() == null) {
            gamePackage.setOrderCount(0);
        }
        return packageRepository.save(gamePackage);
    }
    
    /**
     * Update package
     */
    public GamePackage updatePackage(GamePackage gamePackage) {
        return packageRepository.save(gamePackage);
    }
    
    /**
     * Delete package
     */
    public void deletePackage(Long id) {
        packageRepository.deleteById(id);
    }
    
    /**
     * Toggle package active status
     */
    public GamePackage togglePackageActive(Long id) {
        Optional<GamePackage> packageOpt = packageRepository.findById(id);
        if (packageOpt.isPresent()) {
            GamePackage gamePackage = packageOpt.get();
            gamePackage.setActive(!gamePackage.getActive());
            return packageRepository.save(gamePackage);
        }
        return null;
    }
    
    /**
     * Increment order count
     */
    public void incrementOrderCount(Long packageId) {
        Optional<GamePackage> packageOpt = packageRepository.findById(packageId);
        if (packageOpt.isPresent()) {
            GamePackage gamePackage = packageOpt.get();
            gamePackage.setOrderCount(gamePackage.getOrderCount() + 1);
            packageRepository.save(gamePackage);
        }
    }
}