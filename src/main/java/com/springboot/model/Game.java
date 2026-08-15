package com.springboot.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "games")
public class Game {

	// ====== ความยาวสูงสุดที่เราใช้ให้ตรงกับ DB ======
	private static final int MAX_NAME = 100;
	private static final int MAX_DESC = 1000;
	private static final int MAX_CATEGORIES = 512; // ขยายเผื่อ
	private static final int MAX_IMAGE_URL = 1024; // แก้ปัญหา URL ยาว

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(nullable = false, length = MAX_NAME)
	private String name;

	@Column(length = MAX_DESC)
	private String description;

	@Column(length = MAX_CATEGORIES)
	private String categories;

	@Column(length = MAX_IMAGE_URL, nullable = false)
	private String imageUrl;

	@Column(nullable = false)
	private Boolean active = true;

	@Column(nullable = false)
	private Boolean popular = false;

	@Column(nullable = false)
	private Integer orderCount = 0;

	@Column(nullable = false, updatable = false)
	private LocalDateTime createdAt = LocalDateTime.now();

	@Column(nullable = false)
	private LocalDateTime updatedAt = LocalDateTime.now();

	public Game() {
	}

	public Game(String name, String description, String categories, String imageUrl, Boolean popular) {
		this.name = name;
		this.description = description;
		this.categories = categories;
		this.imageUrl = imageUrl;
		this.popular = popular;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCategories() {
		return categories;
	}

	public void setCategories(String categories) {
		this.categories = categories;
	}

	// Helper: get list
	public String[] getCategoryList() {
		if (categories == null || categories.trim().isEmpty())
			return new String[0];
		return categories.split(",");
	}

	// Helper: set list
	public void setCategoryList(String[] categoryArray) {
		if (categoryArray != null && categoryArray.length > 0) {
			this.categories = String.join(",", categoryArray);
		} else {
			this.categories = "";
		}
	}

	// Backward: first category
	public String getCategory() {
		String[] cats = getCategoryList();
		return cats.length > 0 ? cats[0] : "";
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Boolean getActive() {
		return active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	public Boolean getPopular() {
		return popular;
	}

	public void setPopular(Boolean popular) {
		this.popular = popular;
	}

	public Integer getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(Integer orderCount) {
		this.orderCount = orderCount;
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

	@PrePersist
	protected void onCreate() {
		if (this.createdAt == null)
			this.createdAt = LocalDateTime.now();
		this.updatedAt = LocalDateTime.now();
		trimToLengths();
	}

	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = LocalDateTime.now();
		trimToLengths();
	}

	// กันค่าหลุดความยาวคอลัมน์แบบเงียบ ๆ
	private void trimToLengths() {
		if (name != null && name.length() > MAX_NAME) {
			name = name.substring(0, MAX_NAME);
		}
		if (description != null && description.length() > MAX_DESC) {
			description = description.substring(0, MAX_DESC);
		}
		if (categories != null && categories.length() > MAX_CATEGORIES) {
			categories = categories.substring(0, MAX_CATEGORIES);
		}
		if (imageUrl != null && imageUrl.length() > MAX_IMAGE_URL) {
			imageUrl = imageUrl.substring(0, MAX_IMAGE_URL);
		}
	}
}
