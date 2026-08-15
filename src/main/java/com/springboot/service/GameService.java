package com.springboot.service;

import com.springboot.model.Game;
import com.springboot.repository.GameRepository;
import com.springboot.repository.GamePackageRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class GameService {
    
    private final GameRepository gameRepository;
    private final GamePackageRepository packageRepository;
    
    public GameService(GameRepository gameRepository, GamePackageRepository packageRepository) {
        this.gameRepository = gameRepository;
        this.packageRepository = packageRepository;
    }
    
    /**
     * Get all games
     */
    public List<Game> getAllGames() {
        return gameRepository.findAll();
    }
    
    /**
     * Get game by ID
     */
    public Optional<Game> getGameById(Long id) {
        return gameRepository.findById(id);
    }
    
    /**
     * Get all active games
     */
    public List<Game> getActiveGames() {
        return gameRepository.findByActive(true);
    }
    
    /**
     * Get popular games
     */
    public List<Game> getPopularGames() {
        return gameRepository.findByPopularAndActive(true, true);
    }
    
    /**
     * Get games by category
     */
    public List<Game> getGamesByCategory(String category) {
        return gameRepository.findByActiveAndCategory(true, category);
    }
    
    /**
     * Search games by name
     */
    public List<Game> searchGames(String keyword) {
        return gameRepository.findByNameContainingIgnoreCase(keyword);
    }
    
    /**
     * Get games ordered by popularity (order count)
     */
    public List<Game> getGamesByPopularity() {
        return gameRepository.findByActiveOrderByOrderCountDesc(true);
    }
    
    /**
     * Get newest games
     */
    public List<Game> getNewestGames() {
        return gameRepository.findByActiveOrderByCreatedAtDesc(true);
    }
    
    /**
     * Create new game
     */
    public Game createGame(Game game) {
        // Set default values
        if (game.getActive() == null) {
            game.setActive(true);
        }
        if (game.getPopular() == null) {
            game.setPopular(false);
        }
        if (game.getOrderCount() == null) {
            game.setOrderCount(0);
        }
        return gameRepository.save(game);
    }
    
    /**
     * Update game
     */
    public Game updateGame(Game game) {
        return gameRepository.save(game);
    }
    
    /**
     * Delete game
     */
    public void deleteGame(Long id) {
        // First delete all packages associated with this game
        Optional<Game> gameOpt = gameRepository.findById(id);
        if (gameOpt.isPresent()) {
            Game game = gameOpt.get();
            // Delete all packages first
            packageRepository.findByGame(game).forEach(pkg -> packageRepository.delete(pkg));
        }
        // Then delete the game
        gameRepository.deleteById(id);
    }
    
    /**
     * Toggle game active status
     */
    public Game toggleGameActive(Long id) {
        Optional<Game> gameOpt = gameRepository.findById(id);
        if (gameOpt.isPresent()) {
            Game game = gameOpt.get();
            game.setActive(!game.getActive());
            return gameRepository.save(game);
        }
        return null;
    }
    
    /**
     * Toggle game popular status
     */
    public Game toggleGamePopular(Long id) {
        Optional<Game> gameOpt = gameRepository.findById(id);
        if (gameOpt.isPresent()) {
            Game game = gameOpt.get();
            game.setPopular(!game.getPopular());
            return gameRepository.save(game);
        }
        return null;
    }
    
    /**
     * Increment order count when a new order is placed
     */
    public void incrementOrderCount(Long gameId) {
        Optional<Game> gameOpt = gameRepository.findById(gameId);
        if (gameOpt.isPresent()) {
            Game game = gameOpt.get();
            game.setOrderCount(game.getOrderCount() + 1);
            gameRepository.save(game);
        }
    }
    
    /**
     * Get all categories (distinct)
     */
    public List<String> getAllCategories() {
        return gameRepository.findAll().stream()
                .flatMap(game -> {
                    String[] cats = game.getCategoryList();
                    return java.util.Arrays.stream(cats);
                })
                .distinct()
                .sorted()
                .toList();
    }
    
    /**
     * Count active games
     */
    public long countActiveGames() {
        return gameRepository.countByActive(true);
    }
    
    /**
     * Count all games
     */
    public long countAllGames() {
        return gameRepository.count();
    }
    
    /**
     * Update game details
     */
    public Game updateGameDetails(Long gameId, String name, String description, String category, String imageUrl) {
        Optional<Game> gameOpt = gameRepository.findById(gameId);
        if (gameOpt.isPresent()) {
            Game game = gameOpt.get();
            if (name != null && !name.isEmpty()) {
                game.setName(name);
            }
            if (description != null) {
                game.setDescription(description);
            }
            if (category != null && !category.isEmpty()) {
                game.setCategories(category);
            }
            if (imageUrl != null) {
                game.setImageUrl(imageUrl);
            }
            return gameRepository.save(game);
        }
        return null;
    }
}