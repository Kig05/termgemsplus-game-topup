package com.springboot.controller;

import com.springboot.dto.LoginRequest;
import com.springboot.dto.RegisterRequest;
import com.springboot.model.User;
import com.springboot.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
public class AuthController {
    
    private final UserService userService;
    
    public AuthController(UserService userService) {
        this.userService = userService;
    }
    
    /**
     * Show login page
     */
    @GetMapping("/login")
    public String showLoginPage(HttpSession session, Model model) {
        // Redirect if already logged in
        if (session.getAttribute("user") != null) {
            return "redirect:/home";
        }
        model.addAttribute("loginRequest", new LoginRequest());
        return "login";
    }
    
    /**
     * Process login
     */
    @PostMapping("/login")
    public String processLogin(@ModelAttribute LoginRequest loginRequest,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        
        // Validate input
        if (!loginRequest.isValid()) {
            redirectAttributes.addFlashAttribute("error", "กรุณากรอกชื่อผู้ใช้และรหัสผ่าน");
            return "redirect:/login";
        }
        
        // Authenticate user
        Optional<User> userOpt = userService.login(loginRequest.getUsername(), loginRequest.getPassword());
        
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            
            // Check if user is active
            if (!user.getActive()) {
                redirectAttributes.addFlashAttribute("error", "ไอดีของคุณถูกระงับ. โปรติดต่อเรา.");
                return "redirect:/login";
            }
            
            // Store user in session
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            
            redirectAttributes.addFlashAttribute("success", "Welcome back, " + user.getUsername() + "!");
            
            // Redirect based on role
            if ("admin".equals(user.getRole())) {
                return "redirect:/admin/dashboard";
            } else {
                return "redirect:/home";
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "ไอดีหรือรหัสผ่านไม่ถูกต้อง");
            return "redirect:/login";
        }
    }
    
    /**
     * Show registration page
     */
    @GetMapping("/register")
    public String showRegisterPage(HttpSession session, Model model) {
        // Redirect if already logged in
        if (session.getAttribute("user") != null) {
            return "redirect:/home";
        }
        model.addAttribute("registerRequest", new RegisterRequest());
        return "register";
    }
    
    /**
     * Process registration
     */
    @PostMapping("/register")
    public String processRegister(@ModelAttribute RegisterRequest registerRequest,
                                 RedirectAttributes redirectAttributes) {
        
        // Validate basic fields
        if (!registerRequest.isValid()) {
            redirectAttributes.addFlashAttribute("error", "กรุณากรอกข้อมูลให้ครบถ้วน");
            return "redirect:/register";
        }
        
        // Validate username format
        if (!registerRequest.isUsernameValid()) {
            redirectAttributes.addFlashAttribute("error", "ไอดีต้องเป็นตัวอักษรหรือตัวเลขเท่านั้น และมีความยาวอย่างน้อย 3 ตัวอักษร");
            return "redirect:/register";
        }
        
        // Validate password strength
        if (!registerRequest.isPasswordStrong()) {
            redirectAttributes.addFlashAttribute("error", "พาสเวิร์ดต้องมีความยาวอย่างน้อย 6 ตัวอักษร");
            return "redirect:/register";
        }
        
        // Validate password match
        if (!registerRequest.isPasswordMatch()) {
            redirectAttributes.addFlashAttribute("error", "พาสเวิร์ดไม่ตรงกัน");
            return "redirect:/register";
        }
        
        // Validate email format
        if (!registerRequest.isEmailValid()) {
            redirectAttributes.addFlashAttribute("error", "รูปแบบอีเมลไม่ถูกต้อง");
            return "redirect:/register";
        }
        
        // Check if username already exists
        if (userService.isUsernameExists(registerRequest.getUsername())) {
            redirectAttributes.addFlashAttribute("error", "ไอดีนี้มีผู้ใช้แล้ว");
            return "redirect:/register";
        }
        
        // Check if email already exists
        if (userService.isEmailExists(registerRequest.getEmail())) {
            redirectAttributes.addFlashAttribute("error", "อีเมลนี้มีผู้ใช้แล้ว");
            return "redirect:/register";
        }
        
        // Create new user
        User newUser = new User();
        newUser.setUsername(registerRequest.getUsername());
        newUser.setPassword(registerRequest.getPassword());
        newUser.setEmail(registerRequest.getEmail());
        newUser.setFullName(registerRequest.getFullName());
        newUser.setPhoneNumber(registerRequest.getPhoneNumber());
        newUser.setRole("user");
        newUser.setBalance(0.0);
        newUser.setActive(true);
        
        userService.register(newUser);
        
        redirectAttributes.addFlashAttribute("success", "สมัครเสร็จสิ้น! คุณสามารถเข้าสู่ระบบได้ทันที");
        return "redirect:/login";
    }
    
    /**
     * Logout
     */
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        session.invalidate();
        redirectAttributes.addFlashAttribute("success", "คุณได้ออกจากระบบเรียบร้อยแล้ว");
        return "redirect:/login";
    }
    
    /**
     * Root redirect to login or home
     */
    @GetMapping("/")
    public String index(HttpSession session) {
        if (session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if ("admin".equals(user.getRole())) {
                return "redirect:/admin/dashboard";
            }
            return "redirect:/home";
        }
        return "redirect:/login";
    }
}