package com.springboot.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "topup_orders")
public class TopUpOrder {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "game_id", nullable = false)
	private Game game;

	@Column(nullable = false, length = 100)
	private String packageName;

	@Column(nullable = false)
	private Double amount; // Price

	@Column(nullable = false, length = 100)
	private String gameUserId;

	@Column(length = 100)
	private String gameServerName; 

	@Column(nullable = false, length = 20)
	private String status = "pending"; // pending, processing, completed, failed

	@Column(length = 500)
	private String note;

	@Column(nullable = false, updatable = false)
	private LocalDateTime createdAt = LocalDateTime.now();

	@Column(nullable = false)
	private LocalDateTime updatedAt = LocalDateTime.now();

	@Column
	private LocalDateTime completedAt;

	public TopUpOrder() {
	}

	public TopUpOrder(User user, Game game, String packageName, Double amount, String gameUserId) {
		this.user = user;
		this.game = game;
		this.packageName = packageName;
		this.amount = amount;
		this.gameUserId = gameUserId;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Game getGame() {
		return game;
	}

	public void setGame(Game game) {
		this.game = game;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public LocalDateTime getCompletedAt() {
		return completedAt;
	}

	public void setCompletedAt(LocalDateTime completedAt) {
		this.completedAt = completedAt;
	}

	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = LocalDateTime.now();
	}
}