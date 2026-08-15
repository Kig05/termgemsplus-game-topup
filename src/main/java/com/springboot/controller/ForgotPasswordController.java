package com.springboot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ForgotPasswordController {

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        // ชี้ไป JSP: /WEB-INF/views/auth/forgot-password.jsp
        return "auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("identifier") String identifier,
                                        RedirectAttributes ra) {
        if (identifier == null || identifier.trim().isEmpty()) {
            ra.addFlashAttribute("error", "กรุณากรอกอีเมลหรือชื่อผู้ใช้");
            return "redirect:/forgot-password";
        }
        ra.addFlashAttribute("success", "ถ้าพบข้อมูลในระบบ เราได้ส่งลิงก์รีเซ็ตรหัสผ่านให้แล้ว");
        return "redirect:/forgot-password";
    }
}
