package com.springboot.controller;

import com.springboot.dto.TopUpRequest;
import com.springboot.model.Game;
import com.springboot.model.GamePackage;
import com.springboot.model.TopUpOrder;
import com.springboot.model.User;
import com.springboot.service.GameService;
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
@RequestMapping("/topup")
public class TopUpController {
    
    private final GameService gameService;
    private final GamePackageService packageService;
    private final TopUpOrderService orderService;
    private final UserService userService;
    
    public TopUpController(GameService gameService, GamePackageService packageService,
                          TopUpOrderService orderService, UserService userService) {
        this.gameService = gameService;
        this.packageService = packageService;
        this.orderService = orderService;
        this.userService = userService;
    }
    
    /**
     * Show top-up page for specific game
     */
    @GetMapping("/{gameId}")
    public String showTopUpPage(@PathVariable Long gameId,
                               HttpSession session,
                               Model model,
                               RedirectAttributes redirectAttributes) {
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        // Get game details
        Optional<Game> gameOpt = gameService.getGameById(gameId);
        if (gameOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "ค้นหาเกมไม่พบ");
            return "redirect:/games";
        }
        
        Game game = gameOpt.get();
        
        // Check if game is active
        if (!game.getActive()) {
            redirectAttributes.addFlashAttribute("error", "เกมนี้ไม่พร้อมให้บริการ");
            return "redirect:/games";
        }
        
        // Get packages for this game
        List<GamePackage> packages = packageService.getActivePackagesByGameId(gameId);
        
        // Debug log
        System.out.println("Game ID: " + gameId);
        System.out.println("Game Name: " + game.getName());
        System.out.println("Total Packages Found: " + packages.size());
        for (GamePackage pkg : packages) {
            System.out.println("  - Package: " + pkg.getName() + " | Price: " + pkg.getPrice() + " | Active: " + pkg.getActive());
        }
        
        model.addAttribute("user", user);
        model.addAttribute("game", game);
        model.addAttribute("packages", packages);
        model.addAttribute("topUpRequest", new TopUpRequest());
        
        return "topup";
    }
    
    /**
     * Process top-up order
     */
    @PostMapping("/process")
    public String processTopUp(@ModelAttribute TopUpRequest topUpRequest,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        // ✅ เพิ่มการ validate packageId
        if (topUpRequest.getPackageId() == null) {
            redirectAttributes.addFlashAttribute("error", "กรุณาเลือกแพ็กเกจ");
            return "redirect:/topup/" + topUpRequest.getGameId();
        }
        
        // Validate request
        if (!topUpRequest.isValid()) {
            redirectAttributes.addFlashAttribute("error", "กรุณากรอกข้อมูลให้ครบถ้วน");
            return "redirect:/topup/" + topUpRequest.getGameId();
        }
        
        // Validate amount
        if (!topUpRequest.isAmountValid()) {
            redirectAttributes.addFlashAttribute("error", "กรอกจำนวนเงินไม่ถูกต้อง. กรอกจำนวนเงินได้ระหว่าง 10 - 10000");
            return "redirect:/topup/" + topUpRequest.getGameId();
        }
        
        // Check if user has sufficient balance
        if (!userService.hasSufficientBalance(user.getId(), topUpRequest.getAmount())) {
            redirectAttributes.addFlashAttribute("error", "ยอดเงินของคุณไม่เพียงพอ. กรุณาเติมเงิน.");
            return "redirect:/topup/" + topUpRequest.getGameId();
        }
        
        // ✅ ใช้ packageId จาก topUpRequest
        TopUpOrder order = orderService.createOrderWithPayment(
            user.getId(),
            topUpRequest.getGameId(),
            topUpRequest.getPackageId(),  // ✅ ส่ง packageId ไปด้วย
            topUpRequest.getPackageName(),
            topUpRequest.getAmount(),
            topUpRequest.getGameUserId(),
            topUpRequest.getGameServerName()
        );
        
        if (order == null) {
            redirectAttributes.addFlashAttribute("error", "การสร้างออเดอร์ผิดพลาด. โปรดลองใหม่อีกครั้ง.");
            return "redirect:/topup/" + topUpRequest.getGameId();
        }
        
        // Update session user balance
        Optional<User> updatedUser = userService.getUserById(user.getId());
        updatedUser.ifPresent(u -> session.setAttribute("user", u));
        
        redirectAttributes.addFlashAttribute("success", "สร้างออเดอร์สำเร็จ! หมายเลขออเดอร์: #" + order.getId());
        return "redirect:/orders";
    }
    
    /**
     * Show user orders
     */
    @GetMapping("/orders")
    public String showOrders(HttpSession session, Model model) {
        return "redirect:/orders";
    }
}