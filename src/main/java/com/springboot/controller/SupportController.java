package com.springboot.controller;

import com.springboot.model.Support;
import com.springboot.service.SupportService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class SupportController {

    private final SupportService supportService;
    public SupportController(SupportService supportService) {
        this.supportService = supportService;
    }

    // GET: แสดงหน้าแบบฟอร์ม
    @GetMapping("/support")
    public String supportForm(Model model) {
        return "support"; // -> /WEB-INF/jsp/support.jsp
    }

    // POST: รับฟอร์มและบันทึก
    @PostMapping("/support/submit")
    public String submitSupport(
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam String subject,
            @RequestParam String category,
            @RequestParam(required = false) String orderId,
            @RequestParam String message,
            RedirectAttributes ra
    ) {
        Support t = new Support();
        t.setName(name);
        t.setEmail(email);
        t.setSubject(subject);
        t.setCategory(category);
        t.setOrderId(orderId);
        t.setMessage(message);
        supportService.save(t);

        ra.addFlashAttribute("success", "ส่งคำร้องเรียบร้อย เราจะติดต่อกลับทางอีเมล");
        return "redirect:/support";
    }
}