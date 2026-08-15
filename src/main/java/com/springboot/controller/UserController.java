package com.springboot.controller;

import com.springboot.dto.PasswordChangeRequest;
import com.springboot.dto.ProfileUpdateRequest;
import com.springboot.model.TopUpOrder;
import com.springboot.model.User;
import com.springboot.service.TopUpOrderService;
import com.springboot.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Controller
@Transactional
public class UserController {
    
    private final UserService userService;
    private final TopUpOrderService orderService;
    
    public UserController(UserService userService, TopUpOrderService orderService) {
        this.userService = userService;
        this.orderService = orderService;
    }
    
    /**
     * Show user profile page
     */
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        // Check if user is logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        // Get fresh user data
        Optional<User> updatedUser = userService.getUserById(user.getId());
        if (updatedUser.isPresent()) {
            user = updatedUser.get();
            session.setAttribute("user", user);
        }
        
        // Get user statistics
        long totalOrders = orderService.countOrdersByUser(user);
        long pendingOrders = orderService.getOrdersByUserAndStatus(user, "pending").size();
        Double totalSpent = orderService.getTotalRevenueByUser(user);
        
        model.addAttribute("user", user);
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("pendingOrders", pendingOrders);
        model.addAttribute("totalSpent", totalSpent != null ? totalSpent : 0.0);
        model.addAttribute("profileUpdateRequest", new ProfileUpdateRequest());
        model.addAttribute("passwordChangeRequest", new PasswordChangeRequest());
        
        return "profile";
    }
    
    /**
     * Update user profile
     */
    @PostMapping("/profile/update")
    public String updateProfile(@ModelAttribute ProfileUpdateRequest request,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        // Validate request
        if (!request.isValid()) {
            redirectAttributes.addFlashAttribute("error", "Please provide at least one field to update");
            return "redirect:/profile";
        }
        
        // Validate email format if provided
        if (!request.isEmailValid()) {
            redirectAttributes.addFlashAttribute("error", "Invalid email format");
            return "redirect:/profile";
        }
        
        // Update profile
        User updatedUser = userService.updateProfile(
            user.getId(),
            request.getFullName(),
            request.getEmail(),
            request.getPhoneNumber()
        );
        
        if (updatedUser != null) {
            session.setAttribute("user", updatedUser);
            redirectAttributes.addFlashAttribute("success", "Profile updated successfully!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to update profile");
        }
        
        return "redirect:/profile";
    }
    
    /**
     * Change password
     */
    @PostMapping("/profile/change-password")
    public String changePassword(@ModelAttribute PasswordChangeRequest request,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        // Validate request
        if (!request.isValid()) {
            redirectAttributes.addFlashAttribute("error", "Please fill in all password fields");
            return "redirect:/profile";
        }
        
        // Check if passwords match
        if (!request.isPasswordMatch()) {
            redirectAttributes.addFlashAttribute("error", "New passwords do not match");
            return "redirect:/profile";
        }
        
        // Check password strength
        if (!request.isNewPasswordStrong()) {
            redirectAttributes.addFlashAttribute("error", "New password must be at least 6 characters long");
            return "redirect:/profile";
        }
        
        // Check if new password is different from old
        if (!request.isPasswordDifferent()) {
            redirectAttributes.addFlashAttribute("error", "New password must be different from old password");
            return "redirect:/profile";
        }
        
        // Change password
        boolean success = userService.changePassword(
            user.getId(),
            request.getOldPassword(),
            request.getNewPassword()
        );
        
        if (success) {
            redirectAttributes.addFlashAttribute("success", "Password changed successfully!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Incorrect old password");
        }
        
        return "redirect:/profile";
    }
    
    /**
     * Show user orders
     */
    @GetMapping("/orders")
    public String showOrders(@RequestParam(required = false) String status,
                            HttpSession session,
                            Model model) {
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        // Get fresh user data for balance
        Optional<User> updatedUser = userService.getUserById(user.getId());
        if (updatedUser.isPresent()) {
            user = updatedUser.get();
            session.setAttribute("user", user);
        }
        
        List<TopUpOrder> orders;
        
        try {
            // Filter by status if provided
            if (status != null && !status.trim().isEmpty()) {
                orders = orderService.getOrdersByUserAndStatus(user, status);
                model.addAttribute("selectedStatus", status);
            } else {
                orders = orderService.getOrdersByUser(user);
            }
            
            // Force load relationships
            for (TopUpOrder order : orders) {
                if (order.getGame() != null) {
                    order.getGame().getName(); // Force lazy load
                }
                if (order.getUser() != null) {
                    order.getUser().getUsername(); // Force lazy load
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            orders = List.of(); // Empty list on error
        }
        
        model.addAttribute("user", user);
        model.addAttribute("orders", orders);
        
        return "orders";
    }
    
    /**
     * Show add balance page
     */
    @GetMapping("/add-balance")
    public String showAddBalancePage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        // Get fresh user data
        Optional<User> updatedUser = userService.getUserById(user.getId());
        if (updatedUser.isPresent()) {
            user = updatedUser.get();
            session.setAttribute("user", user);
        }
        
        model.addAttribute("user", user);
        return "add-balance";
    }
    
    /**
     * Process add balance
     */
    @PostMapping("/add-balance")
    public String processAddBalance(@RequestParam Double amount,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        if (amount == null || amount <= 0) {
            redirectAttributes.addFlashAttribute("error", "Amount must be greater than 0");
            return "redirect:/add-balance";
        }
        
        if (amount > 100000) {
            redirectAttributes.addFlashAttribute("error", "Maximum amount is 100,000 per transaction");
            return "redirect:/add-balance";
        }
        
        // Add balance
        User updatedUser = userService.addBalance(user.getId(), amount);
        if (updatedUser != null) {
            session.setAttribute("user", updatedUser);
            redirectAttributes.addFlashAttribute("success", 
                "Successfully added ฿" + String.format("%.2f", amount) + " to your account!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to add balance. Please try again.");
        }
        
        return "redirect:/profile";
    }
    
    /**
     * Cancel order
     */
    @PostMapping("/orders/cancel/{orderId}")
    public String cancelOrder(@PathVariable Long orderId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        boolean success = orderService.cancelOrder(orderId);
        
        if (success) {
            // Update session user balance
            Optional<User> updatedUser = userService.getUserById(user.getId());
            updatedUser.ifPresent(u -> session.setAttribute("user", u));
            
            redirectAttributes.addFlashAttribute("success", "Order cancelled and refunded successfully!");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to cancel order. Only pending orders can be cancelled.");
        }
        
        return "redirect:/orders";
    }
    
}