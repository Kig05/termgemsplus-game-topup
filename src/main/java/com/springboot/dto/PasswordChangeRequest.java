package com.springboot.dto;

/**
 * Data Transfer Object for Password Change Request
 */
public class PasswordChangeRequest {
    
    private String oldPassword;
    private String newPassword;
    private String confirmPassword;
    
    public PasswordChangeRequest() {}
    
    public PasswordChangeRequest(String oldPassword, String newPassword, String confirmPassword) {
        this.oldPassword = oldPassword;
        this.newPassword = newPassword;
        this.confirmPassword = confirmPassword;
    }
    
    public String getOldPassword() {
        return oldPassword;
    }
    
    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }
    
    public String getNewPassword() {
        return newPassword;
    }
    
    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }
    
    public String getConfirmPassword() {
        return confirmPassword;
    }
    
    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }
    
    // Validation methods
    public boolean isValid() {
        return oldPassword != null && !oldPassword.trim().isEmpty()
            && newPassword != null && !newPassword.trim().isEmpty()
            && confirmPassword != null && !confirmPassword.trim().isEmpty();
    }
    
    public boolean isPasswordMatch() {
        return newPassword != null && newPassword.equals(confirmPassword);
    }
    
    public boolean isNewPasswordStrong() {
        return newPassword != null && newPassword.length() >= 6;
    }
    
    public boolean isPasswordDifferent() {
        return oldPassword != null && newPassword != null 
            && !oldPassword.equals(newPassword);
    }
    
    @Override
    public String toString() {
        return "PasswordChangeRequest{" +
                "oldPassword='[PROTECTED]'" +
                ", newPassword='[PROTECTED]'" +
                ", confirmPassword='[PROTECTED]'" +
                '}';
    }
}