package com.springboot.controller;

import com.springboot.model.Game;
import com.springboot.model.User;
import com.springboot.service.GameService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class HomeController {
    
    private final GameService gameService;
    
    public HomeController(GameService gameService) {
        this.gameService = gameService;
    }
    
    /**
     * Home page - show all games
     */
    @GetMapping("/home")
    public String home(HttpSession session, Model model) {
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        //if (user == null) {
        //    return "redirect:/login";
        //}
        
        // Get popular games
        List<Game> popularGames = gameService.getPopularGames();
        
        // Get all active games
        List<Game> allGames = gameService.getActiveGames();
        
        // Get categories
        List<String> categories = gameService.getAllCategories();
        
        model.addAttribute("user", user);
        model.addAttribute("popularGames", popularGames);
        model.addAttribute("allGames", allGames);
        model.addAttribute("categories", categories);
        
        return "home";
    }
    
    /**
     * Games page - show all games with filters
     */
    @GetMapping("/games")
    public String games(@RequestParam(required = false) String category,
                       @RequestParam(required = false) String search,
                       HttpSession session,
                       Model model) {
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        List<Game> games;
        
        // Filter by search
        if (search != null && !search.trim().isEmpty()) {
            games = gameService.searchGames(search);
            model.addAttribute("search", search);
        }
        // Filter by category
        else if (category != null && !category.trim().isEmpty()) {
            games = gameService.getGamesByCategory(category);
            model.addAttribute("selectedCategory", category);
        }
        // Show all games
        else {
            games = gameService.getActiveGames();
        }
        
        // Get all categories for filter dropdown
        List<String> categories = gameService.getAllCategories();
        
        model.addAttribute("user", user);
        model.addAttribute("games", games);
        model.addAttribute("categories", categories);
        
        return "games";
    }
}