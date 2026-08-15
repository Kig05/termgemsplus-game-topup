<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Profile — TermGems+</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    :root{
      --bg-1:#0b0614; --bg-2:#150a22;
      --text:#ffffff;
      --muted:#efe6ff;
      --muted-2:#e3d9ff;
      --border:rgba(255,255,255,.20);
      --pink:#ff2bb3; --pink-2:#ff6bd8;
      --nav-bg: rgba(12, 6, 18, .8);
      --nav-bg-scrolled: rgba(12, 6, 18, .95);
      --ok:#22c55e; --warn:#f59e0b; --danger:#ef4444;
      --placeholder:#f3e9ff;
    }

    body{
      color:var(--text);
      background:
        radial-gradient(1200px 600px at -10% -20%, #3b0c59 0%, transparent 60%),
        radial-gradient(900px 500px at 110% -10%, #27104d 0%, transparent 55%),
        radial-gradient(1200px 700px at 90% 120%, #140a2d 0%, transparent 65%),
        linear-gradient(180deg, var(--bg-2), var(--bg-1));
      min-height:100vh;
    }

    /* Navbar */
    .navbar.neon-nav{
      position:sticky;top:0;z-index:1030;
      background:var(--nav-bg);
      backdrop-filter:blur(10px);
      border-bottom:1px solid var(--border);
      transition:.3s;
    }
    .navbar.neon-nav.stuck{
      background:var(--nav-bg-scrolled);
      box-shadow:0 10px 30px rgba(0,0,0,.35);
      padding-top:.35rem;padding-bottom:.35rem;
    }
    .navbar .nav-link{ color:#f5edff; font-weight:700; }
    .navbar .nav-link:hover,.navbar .nav-link.active{ color:#fff; }

    .brand-badge{display:flex;align-items:center;gap:.6rem;color:#fff;font-weight:800;}
    .brand-logo{
      width:34px;height:34px;border-radius:10px;
      display:grid;place-items:center;
      color:#fff;
      background:radial-gradient(120% 120% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%);
    }

    .search-wrap{
      background:rgba(255,255,255,.1);
      border:1px solid var(--border);
      border-radius:12px;
      padding:.35rem .7rem;
      display:flex;align-items:center;gap:.5rem;min-width:280px;
    }
    .search-wrap input{
      background:transparent;border:0;outline:none;
      color:#fff;width:100%;
    }
    .search-wrap input::placeholder{color:var(--placeholder);}

    /* Buttons */
    .btn-neon{
      color:#fff;font-weight:800;border-radius:12px;
      padding:.5rem .9rem;border:2px solid var(--pink);
      box-shadow:0 0 0 3px rgba(255,43,179,.15),
                 0 0 18px rgba(255,43,179,.35) inset;
      background:linear-gradient(180deg,rgba(255,255,255,.05),rgba(255,255,255,.08));
      transition:.3s;
    }
    .btn-neon:hover{
      color:#160422;
      background:linear-gradient(90deg,var(--pink),var(--pink-2));
      box-shadow:0 10px 26px rgba(255,43,179,.35);
    }
    .btn-primary{
      background:linear-gradient(90deg,var(--pink),var(--pink-2));
      border:0;font-weight:800;color:#160422;
      box-shadow:0 10px 26px rgba(255,43,179,.28);
    }
    .btn-warning{
      background:linear-gradient(90deg,#ffd27b,#ffb547);
      border:0;font-weight:800;color:#3b2500;
      box-shadow:0 10px 26px rgba(255,181,71,.28);
    }

    /* Card + Form */
    .neon-card{
      border-radius:18px;
      border:1px solid rgba(255,255,255,.25);
      background:linear-gradient(180deg,rgba(255,255,255,.10),rgba(255,255,255,.05));
      backdrop-filter:blur(14px);
      box-shadow:0 16px 44px rgba(0,0,0,.45);
      color:#fff;
    }
    .card-header{
      border-bottom:1px solid rgba(255,255,255,.25);
      background:transparent;
      color:#fff;
    }
    .form-label{color:#fff;font-weight:600;}
    .form-control,.form-select{
      background:rgba(255,255,255,.14);
      border:1px solid rgba(255,255,255,.3);
      color:#fff;
    }
    .form-control::placeholder{color:var(--placeholder);}
    .form-control:disabled,
    .form-control[readonly]{
      background:rgba(255,255,255,.10);
      color:#fff;
      -webkit-text-fill-color:#fff;
    }
    .form-control:focus,.form-select:focus{
      background:rgba(255,255,255,.18);
      border-color:rgba(255,43,179,.65);
      box-shadow:0 0 0 .2rem rgba(255,43,179,.3);
    }
    .form-text{color:#f2eaff;}
    .invalid-feedback{color:#ffd9df;}

    /* Profile Left */
    .profile-avatar{
      width:130px;height:130px;border-radius:20px;
      display:grid;place-items:center;
      font-size:3rem;color:#fff;
      margin:-70px auto 1rem;
      background:radial-gradient(130% 130% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%);
      border:4px solid rgba(255,255,255,.9);
      box-shadow:0 20px 44px rgba(124,58,237,.35);
    }
    .list-kv .kv{display:flex;justify-content:space-between;padding:.6rem 0;border-bottom:1px dashed rgba(255,255,255,.2);}
    .list-kv .kv:last-child{border-bottom:0;}
    .list-kv .kv span:last-child{color:#fff;}
    .text-soft{color:var(--muted);}
    .text-softer{color:var(--muted-2);}

    /* Balance */
    .balance-display{
      border-radius:16px;
      border:1px solid rgba(255,255,255,.25);
      background:linear-gradient(145deg,rgba(255,255,255,.12),rgba(255,255,255,.05));
      text-align:center;
      padding:1.4rem;
    }
    .balance-display .amount{font-weight:900;font-size:2.4rem;color:#fff;}

    footer{border-top:1px solid var(--border);color:#f5eaff;}
  </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg neon-nav" id="mainNav">
  <div class="container">
    <a class="navbar-brand brand-badge" href="${cp}/home">
      <span class="brand-logo"><i class="fa-solid fa-gem"></i></span>TermGems+
    </a>

    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ms-4">
        <li class="nav-item"><a class="nav-link" href="${cp}/home">หน้าหลัก</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/games?mode=uid">เกมทั้งหมด</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/orders">ประวัติการเติม</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/support">ติดต่อเรา</a></li>
        <li class="nav-item"><a class="nav-link active" href="${cp}/profile">โปรไฟล์</a></li>
      </ul>

<!-- เปลี่ยนเป็น 'ออกจากระบบ' เมื่อมี user -->
        <c:choose>
          <c:when test="${not empty user}">
            <!-- แบบลิงก์ GET ธรรมดา -->
            <a href="${cp}/logout" class="btn btn-neon">
              <i class="fa-solid fa-right-from-bracket me-1"></i> ออกจากระบบ
            </a>
            <!--
            // ถ้าใช้ Spring Security แนะนำใช้ POST /logout
            <form action="${cp}/logout" method="post" class="m-0">
              <button type="submit" class="btn btn-neon">
                <i class="fa-solid fa-right-from-bracket me-1"></i> ออกจากระบบ
              </button>
            </form>
            -->
          </c:when>
          <c:otherwise>
            <a href="${cp}/login" class="btn btn-neon">
              <i class="fa-solid fa-user me-1"></i> เข้าสู่ระบบ
            </a>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- Mobile: แสดงปุ่ม login/logout ใต้เมนู -->
      <div class="d-lg-none mt-3">
        <c:choose>
          <c:when test="${not empty user}">
            <a href="${cp}/logout" class="btn btn-neon w-100">
              <i class="fa-solid fa-right-from-bracket me-1"></i> ออกจากระบบ
            </a>
            <!--
            <form action="${cp}/logout" method="post" class="mt-2">
              <button type="submit" class="btn btn-neon w-100">
                <i class="fa-solid fa-right-from-bracket me-1"></i> ออกจากระบบ
              </button>
            </form>
            -->
          </c:when>
          <c:otherwise>
            <a href="${cp}/login" class="btn btn-neon w-100">
              <i class="fa-solid fa-user me-1"></i> เข้าสู่ระบบ
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</nav>

<!-- MAIN -->
<main class="container my-5">
  <div class="row g-4">
    <!-- Left -->
    <div class="col-lg-4">
      <div class="card neon-card text-center p-4">
        <div class="profile-avatar"><i class="fas fa-user"></i></div>
        <h4>${user.fullName}</h4>
        <p class="text-softer mb-2">@${user.username}</p>
        <span class="badge bg-secondary">user</span>

        <hr class="my-3" style="border-color:rgba(255,255,255,.3)">

        <div class="list-kv small text-start">
          <div class="kv"><span class="text-soft"><i class="fa-regular fa-envelope me-2"></i>อีเมล</span><span>${user.email}</span></div>
          <div class="kv"><span class="text-soft"><i class="fa-solid fa-phone me-2"></i>เบอร์โทร</span><span>${user.phoneNumber}</span></div>
          <div class="kv"><span class="text-soft"><i class="fa-solid fa-circle me-2"></i>สถานะ</span>
            <span class="badge ${user.active?'bg-success':'bg-danger'}">${user.active?'เปิดใช้งาน':'ปิดการใช้งาน'}</span></div>
          <div class="kv"><span class="text-soft"><i class="fa-regular fa-calendar me-2"></i>เป็นสมาชิกตั้งแต่</span><span>${user.createdAt}</span></div>
        </div>
      </div>

      <div class="balance-display mt-3 neon-card">
        <div class="small text-soft"><i class="fas fa-wallet me-1"></i>ยอดเงินคงเหลือ</div>
        <div class="amount">฿<fmt:formatNumber value="${user.balance}" pattern="#,##0.00"/></div>
        <a href="${cp}/add-balance" class="btn btn-neon btn-sm mt-2"><i class="fa-solid fa-plus me-1"></i>เติมเงินเข้าบัญชี</a>
      </div>
    </div>

    <!-- Right -->
    <div class="col-lg-8">
      <!-- Update Info -->
      <div class="card neon-card p-4 mb-4">
        <h5 class="mb-3"><i class="fa-solid fa-edit me-2 text-pink"></i>อัปเดตข้อมูลส่วนตัว</h5>
        <form action="${cp}/profile/update" method="post">
          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">ชื่อผู้ใช้</label>
              <input type="text" class="form-control" value="${user.username}" disabled>
              <div class="form-text">ไม่สามารถเปลี่ยนชื่อผู้ใช้ได้</div>
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">ชื่อ-นามสกุล</label>
              <input type="text" name="fullName" class="form-control" value="${user.fullName}" required>
            </div>
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">อีเมล</label>
              <input type="email" name="email" class="form-control" value="${user.email}" placeholder="name@example.com" required>
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">เบอร์โทร</label>
              <input type="tel" name="phoneNumber" class="form-control" value="${user.phoneNumber}" placeholder="08xxxxxxxx">
            </div>
          </div>
          <div class="d-grid"><button type="submit" class="btn btn-primary">บันทึกการเปลี่ยนแปลง</button></div>
        </form>
      </div>

      <!-- Change Password -->
      <div class="card neon-card p-4">
        <h5 class="mb-3"><i class="fa-solid fa-lock me-2 text-pink"></i>เปลี่ยนรหัสผ่าน</h5>
        <form action="${cp}/profile/change-password" method="post">
          <div class="mb-3">
            <label class="form-label">รหัสผ่านปัจจุบัน</label>
            <input type="password" name="oldPassword" class="form-control" required placeholder="••••••••">
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">รหัสผ่านใหม่</label>
              <input type="password" name="newPassword" class="form-control" minlength="6" required placeholder="อย่างน้อย 6 ตัวอักษร">
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">ยืนยันรหัสผ่านใหม่</label>
              <input type="password" name="confirmPassword" class="form-control" minlength="6" required placeholder="พิมพ์อีกครั้ง">
            </div>
          </div>
          <div class="d-grid"><button type="submit" class="btn btn-warning">ยืนยันการเปลี่ยนรหัส</button></div>
        </form>
      </div>
    </div>
  </div>
</main>

<footer class="text-center py-4 mt-5">
  <div class="container small">© 2025 TermGems+. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const nav=document.getElementById('mainNav');
  window.addEventListener('scroll',()=>nav.classList.toggle('stuck',window.scrollY>12));
</script>
</body>
</html>
