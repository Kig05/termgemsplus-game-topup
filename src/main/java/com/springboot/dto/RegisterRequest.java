package com.springboot.dto;

/**
 * Data Transfer Object for Registration Request
 */
public class RegisterRequest {
    
    private String username;
    private String password;
    private String confirmPassword;
    private String email;
    private String fullName;
    private String phoneNumber;
    
    public RegisterRequest() {}
    
    public RegisterRequest(String username, String password, String confirmPassword, 
                          String email, String fullName, String phoneNumber) {
        this.username = username;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.email = email;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getConfirmPassword() {
        return confirmPassword;
    }
    
    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    // Validation methods
    public boolean isValid() {
        return username != null && !username.trim().isEmpty()
            && password != null && !password.trim().isEmpty()
            && email != null && !email.trim().isEmpty()
            && fullName != null && !fullName.trim().isEmpty();
    }
    
    public boolean isPasswordMatch() {
        return password != null && password.equals(confirmPassword);
    }
    
    public boolean isUsernameValid() {
        // Username should be at least 3 characters and alphanumeric
        return username != null && username.length() >= 3 
            && username.matches("^[a-zA-Z0-9_]+$");
    }
    
    public boolean isPasswordStrong() {
        // Password should be at least 6 characters
        return password != null && password.length() >= 6;
    }
    
    public boolean isEmailValid() {
        // Basic email validation
        return email != null && email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
    
    @Override
    public String toString() {
        return "RegisterRequest{" +
                "username='" + username + '\'' +
                ", password='[PROTECTED]'" +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                '}';
    }
}