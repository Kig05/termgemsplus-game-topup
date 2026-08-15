package com.springboot.repository;

import com.springboot.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    /**
     * Find user by username
     */
    Optional<User> findByUsername(String username);
    
    /**
     * Find user by email
     */
    Optional<User> findByEmail(String email);
    
    /**
     * Find user by username and password (for login)
     */
    Optional<User> findByUsernameAndPassword(String username, String password);
    
    /**
     * Check if username exists
     */
    boolean existsByUsername(String username);
    
    /**
     * Check if email exists
     */
    boolean existsByEmail(String email);
    
    /**
     * Find all users by role
     */
    List<User> findByRole(String role);
    
    /**
     * Find all active users
     */
    List<User> findByActive(Boolean active);
    
    /**
     * Find users by role and active status
     */
    List<User> findByRoleAndActive(String role, Boolean active);
    
    /**
     * Count users by role
     */
    long countByRole(String role);
}