package com.springboot.dto;

/**
 * Data Transfer Object for Top-Up Request
 */
public class TopUpRequest {

    private Long gameId;
    private Long packageId;
    private String packageName;
    private Double amount;
    private String gameUserId;
    private String gameServerName;
    private String note;

    public TopUpRequest() {}

    public TopUpRequest(Long gameId, String packageName, Double amount,
                       String gameUserId, String gameServerName) {
        this.gameId = gameId;
        this.packageName = packageName;
        this.amount = amount;
        this.gameUserId = gameUserId;
        this.gameServerName = gameServerName;
    }

    public TopUpRequest(Long gameId, Long packageId, String packageName, Double amount,
                       String gameUserId, String gameServerName) {
        this.gameId = gameId;
        this.packageId = packageId;
        this.packageName = packageName;
        this.amount = amount;
        this.gameUserId = gameUserId;
        this.gameServerName = gameServerName;
    }

    public Long getGameId() {
        return gameId;
    }

    public void setGameId(Long gameId) {
        this.gameId = gameId;
    }
    
    public Long getPackageId() {
        return packageId;
    }

    public void setPackageId(Long packageId) {
        this.packageId = packageId;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public String getGameUserId() {
        return gameUserId;
    }

    public void setGameUserId(String gameUserId) {
        this.gameUserId = gameUserId;
    }

    public String getGameServerName() {
        return gameServerName;
    }

    public void setGameServerName(String gameServerName) {
        this.gameServerName = gameServerName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    // Validation methods
    public boolean isValid() {
        return gameId != null
                && packageName != null && !packageName.trim().isEmpty()
                && amount != null && amount > 0
                && gameUserId != null && !gameUserId.trim().isEmpty();
    }

    public boolean isAmountValid() {
        return amount != null && amount > 0 && amount <= 100000;
    }

    @Override
    public String toString() {
        return "TopUpRequest{" +
                "gameId=" + gameId +
                ", packageId=" + packageId +  // ✅ เพิ่มในส่วน toString
                ", packageName='" + packageName + '\'' +
                ", amount=" + amount +
                ", gameUserId='" + gameUserId + '\'' +
                ", gameServerName='" + gameServerName + '\'' +
                ", note='" + note + '\'' +
                '}';
    }
}