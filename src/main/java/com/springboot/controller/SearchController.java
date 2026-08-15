package com.springboot.controller;

import com.springboot.model.Game;
import com.springboot.repository.GameRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class SearchController {

    private final GameRepository gameRepository;

    public SearchController(GameRepository gameRepository) {
        this.gameRepository = gameRepository;
    }

    @GetMapping("/search")
    public String searchGames(@RequestParam("q") String query, Model model) {
        // ค้นหาเกมที่ชื่อมีคำค้น
        List<Game> results = gameRepository.findByNameContainingIgnoreCase(query);
        model.addAttribute("query", query);
        model.addAttribute("results", results);
        return "search"; // ไปที่หน้า search.jsp
    }
}
