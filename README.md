# 🎮 TermGemsPlus - Game Top-up Website

โปรเจกต์เว็บไซต์เติมเกมออนไลน์ (TermGemsPlus) ที่พัฒนาระบบสำหรับผู้ใช้งานทั่วไป (General User) ให้สามารถเลือกซื้อสินค้า เติมเกม และติดตามสถานะคำสั่งซื้อได้อย่างสะดวกสบาย

## 🌟 Key Features (ฟีเจอร์หลัก)

*   **User Interface:** พัฒนาหน้าเว็บสำหรับผู้ใช้งานทั่วไปด้วย JSP, HTML5, CSS3 และ JavaScript
*   **Core Functionality:** ฟังก์ชันแสดงสินค้า เติมเกม และติดตามสถานะคำสั่งซื้อ
*   **Backend Integration:** เชื่อมต่อข้อมูลจาก Backend เพื่อแสดงข้อมูลสินค้าและรายการสั่งซื้อ
*   **Responsive Design:** ปรับปรุง Responsive UI ให้รองรับการใช้งานบน Desktop และ Mobile Browser

## 💻 Tech Stack

*   **Backend:** Java, Spring Boot
*   **Frontend:** JSP, HTML5, CSS3, JavaScript
*   **Database:** MySQL
*   **Build Tool:** Maven (อ้างอิงจากการตั้งค่าโปรเจกต์ด้วยไฟล์ `pom.xml`)

## 🚀 Getting Started

ขั้นตอนการตั้งค่าและรันโปรเจกต์บนเครื่อง Local

### Prerequisites
*   Java Development Kit (JDK)
*   Maven
*   MySQL Database

### Installation

1. **Clone the repository:**
   \`\`\`bash
   git clone https://github.com/Kig05/termgemsplus-game-topup.git
   cd termgemsplus-game-topup
   \`\`\`

2. **Database Configuration:**
   สร้างฐานข้อมูล MySQL และตั้งค่าการเชื่อมต่อในไฟล์ `src/main/resources/application.properties` (หรือไฟล์ตั้งค่าที่เกี่ยวข้อง):
   \`\`\`properties
   spring.datasource.url=jdbc:mysql://localhost:3306/your_database_name
   spring.datasource.username=your_username
   spring.datasource.password=your_password
   \`\`\`

3. **Run the application:**
   เนื่องจากโปรเจกต์นี้ใช้งาน Maven ผ่านไฟล์ `pom.xml` สามารถรันคำสั่งนี้ได้เลย:
   \`\`\`bash
   mvn spring-boot:run
   \`\`\`
   เปิดเบราว์เซอร์และเข้าไปที่ `http://localhost:8080`

## 👨‍💻 Author
*   **GitHub:** [@Kig05](https://github.com/Kig05/termgemsplus-game-topup)
