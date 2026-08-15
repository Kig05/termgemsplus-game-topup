package com.springboot.service;

import com.springboot.model.User;
import com.springboot.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    
    private final UserRepository userRepository;
    
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    
    /**
     * Get all users
     */
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
    
    /**
     * Get user by ID
     */
    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }
    
    /**
     * Get user by username
     */
    public Optional<User> getUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    
    /**
     * Get user by email
     */
    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    /**
     * Login - authenticate user
     */
    public Optional<User> login(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }
    
    /**
     * Register new user
     */
    public User register(User user) {
        // Set default values
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("user");
        }
        if (user.getBalance() == null) {
            user.setBalance(0.0);
        }
        if (user.getActive() == null) {
            user.setActive(true);
        }
        return userRepository.save(user);
    }
    
    /**
     * Check if username exists
     */
    public boolean isUsernameExists(String username) {
        return userRepository.existsByUsername(username);
    }
    
    /**
     * Check if email exists
     */
    public boolean isEmailExists(String email) {
        return userRepository.existsByEmail(email);
    }
    
    /**
     * Update user
     */
    public User updateUser(User user) {
        return userRepository.save(user);
    }
    
    /**
     * Delete user
     */
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }
    
    /**
     * Get users by role
     */
    public List<User> getUsersByRole(String role) {
        return userRepository.findByRole(role);
    }
    
    /**
     * Get active users
     */
    public List<User> getActiveUsers() {
        return userRepository.findByActive(true);
    }
    
    /**
     * Toggle user active status
     */
    public User toggleUserActive(Long id) {
        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setActive(!user.getActive());
            return userRepository.save(user);
        }
        return null;
    }
    
    /**
     * Add balance to user
     */
    public User addBalance(Long userId, Double amount) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setBalance(user.getBalance() + amount);
            return userRepository.save(user);
        }
        return null;
    }
    
    /**
     * Deduct balance from user
     */
    public User deductBalance(Long userId, Double amount) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (user.getBalance() >= amount) {
                user.setBalance(user.getBalance() - amount);
                return userRepository.save(user);
            }
        }
        return null;
    }
    
    /**
     * Check if user has sufficient balance
     */
    public boolean hasSufficientBalance(Long userId, Double amount) {
        Optional<User> userOpt = userRepository.findById(userId);
        return userOpt.map(user -> user.getBalance() >= amount).orElse(false);
    }
    
    /**
     * Count all users
     */
    public long countAllUsers() {
        return userRepository.count();
    }
    
    /**
     * Count users by role
     */
    public long countUsersByRole(String role) {
        return userRepository.countByRole(role);
    }
    
    /**
     * Change user password
     */
    public boolean changePassword(Long userId, String oldPassword, String newPassword) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (user.getPassword().equals(oldPassword)) {
                user.setPassword(newPassword);
                userRepository.save(user);
                return true;
            }
        }
        return false;
    }
    
    /**
     * Update user profile
     */
    public User updateProfile(Long userId, String fullName, String email, String phoneNumber) {
        Optional<User> userOpt = userRepository.findById(userId);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            if (fullName != null && !fullName.isEmpty()) {
                user.setFullName(fullName);
            }
            if (email != null && !email.isEmpty()) {
                user.setEmail(email);
            }
            if (phoneNumber != null && !phoneNumber.isEmpty()) {
                user.setPhoneNumber(phoneNumber);
            }
            return userRepository.save(user);
        }
        return null;
    }
}