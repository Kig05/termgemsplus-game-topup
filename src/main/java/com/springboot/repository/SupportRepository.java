package com.springboot.repository;


import org.springframework.data.jpa.repository.JpaRepository;

import com.springboot.model.Support;

import java.util.List;

public interface SupportRepository extends JpaRepository<Support, Long> {
	List<Support> findAllByOrderByCreatedAtDesc();
}