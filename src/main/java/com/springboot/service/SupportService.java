package com.springboot.service;


import org.springframework.stereotype.Service;

import com.springboot.model.Support;
import com.springboot.repository.SupportRepository;

import java.util.List;

@Service
public class SupportService {

    private final SupportRepository repo;

    public SupportService(SupportRepository repo) {
        this.repo = repo;
    }

    public List<Support> findAll() {
        return repo.findAllByOrderByCreatedAtDesc();
    }
    
    public Support save(Support t) {
        return repo.save(t);
    }
}