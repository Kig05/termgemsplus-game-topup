package com.springboot.dto;

/**
 * Data Transfer Object for Profile Update Request
 */
public class ProfileUpdateRequest {
    
    private String fullName;
    private String email;
    private String phoneNumber;

    public ProfileUpdateRequest() {}
    
    public ProfileUpdateRequest(String fullName, String email, String phoneNumber) {
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhoneNumber() {
        return phoneNumber;
    }
    
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
    
    // Validation
    public boolean isValid() {
        return (fullName != null && !fullName.trim().isEmpty())
            || (email != null && !email.trim().isEmpty())
            || (phoneNumber != null && !phoneNumber.trim().isEmpty());
    }
    
    public boolean isEmailValid() {
        if (email == null || email.trim().isEmpty()) {
            return true; // Email is optional
        }
        return email.matches("^[A-Za-z0-9+_.-]+@(.+)$");
    }
    
    @Override
    public String toString() {
        return "ProfileUpdateRequest{" +
                "fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                '}';
    }
}