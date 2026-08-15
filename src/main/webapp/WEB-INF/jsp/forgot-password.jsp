<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ลืมรหัสผ่าน — TermGems+</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
  <style>
    :root{--bg-1:#0b0614; --bg-2:#150a22; --text:#e7e3ee; --muted:#b9a9c9; --border:rgba(255,255,255,.08); --pink:#ff2bb3; --pink-2:#ff6bd8; --nav-bg: rgba(12, 6, 18, .75); --nav-bg-scrolled: rgba(12, 6, 18, .92);}
    body{
      color:var(--text);
      background:
        radial-gradient(1200px 600px at -10% -20%, #3b0c59 0%, transparent 60%),
        radial-gradient(900px 500px at 110% -10%, #27104d 0%, transparent 55%),
        radial-gradient(1200px 700px at 90% 120%, #140a2d 0%, transparent 65%),
        linear-gradient(180deg, var(--bg-2), var(--bg-1));
      min-height:100vh; display:flex; flex-direction:column;
    }
    .navbar.neon-nav{position:sticky;top:0;z-index:1030;background:var(--nav-bg);backdrop-filter:blur(10px);border-bottom:1px solid var(--border);}
    .brand-badge{display:flex;align-items:center;gap:.6rem;color:#fff;font-weight:800;}
    .brand-logo{width:34px;height:34px;border-radius:10px;display:grid;place-items:center;color:#fff;background:radial-gradient(120% 120% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%);}
    .auth-wrap{flex:1;display:grid;place-items:center;padding:40px 14px;}
    .auth-card{width:100%; max-width:520px;background:linear-gradient(180deg, rgba(255,255,255,.08), rgba(255,255,255,.04));border:1px solid rgba(255,255,255,.14);border-radius:24px;backdrop-filter: blur(12px);box-shadow:0 20px 46px rgba(0,0,0,.5);padding:22px 18px;}
    .auth-head{display:flex;gap:.6rem;align-items:center;margin-bottom:.6rem;}
    .dot{width:10px;height:10px;border-radius:999px;background:linear-gradient(90deg,#ff2bb3,#ff6bd8);box-shadow:0 0 10px rgba(255,43,179,.8);}
    label{font-weight:700;color:#d7c9ef;}
    .form-control{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.15);color:#fff;}
    .form-control::placeholder{color:#bcaed6;}
    .form-control:focus{border-color:var(--pink);box-shadow:0 0 0 .2rem rgba(255,43,179,.15);}
    .btn-topup-light{display:block;width:100%;background:linear-gradient(90deg,#ff2bb3,#ff6bd8);border:0;border-radius:14px;padding:.85rem 1rem;font-weight:900;color:#160422;box-shadow:0 0 22px rgba(255,43,179,.35);transition:transform .15s ease, opacity .15s ease;}
    .btn-topup-light:hover{opacity:.95;transform:translateY(-2px);}
    .muted{color:#b9a9c9;}
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg neon-nav">
  <div class="container">
    <a class="navbar-brand brand-badge" href="${cp}/home">
      <span class="brand-logo"><i class="fa-solid fa-gem"></i></span>TermGems+
    </a>
  </div>
</nav>

<div class="auth-wrap">
  <div class="auth-card">
    <div class="auth-head">
      <span class="dot"></span>
      <h4 class="mb-0 fw-bold">ลืมรหัสผ่าน</h4>
    </div>
    <div class="muted mb-3">
      กรอกอีเมลหรือชื่อผู้ใช้ของคุณ เราจะส่งลิงก์สำหรับตั้งรหัสผ่านใหม่ให้
    </div>

    <!-- Alerts -->
    <c:if test="${not empty success}">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fa-solid fa-check-circle me-2"></i>${success}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    </c:if>
    <c:if test="${not empty error}">
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>
    </c:if>

    <form action="${cp}/forgot-password" method="post" class="mt-2">
      <div class="mb-3">
        <label for="identifier"><i class="fa-regular fa-envelope me-1"></i> อีเมล หรือ ชื่อผู้ใช้</label>
        <input type="text" class="form-control" id="identifier" name="identifier" placeholder="you@mail.com หรือ gamerz_01" required>
      </div>
      <button type="submit" class="btn-topup-light">
        <i class="fa-solid fa-paper-plane me-2"></i> ส่งลิงก์รีเซ็ตรหัสผ่าน
      </button>
    </form>

    <div class="text-center mt-3">
      <a href="${cp}/login" class="link-light text-decoration-none">
        <i class="fa-solid fa-arrow-left me-1"></i> กลับไปหน้าเข้าสู่ระบบ
      </a>
    </div>
  </div>
</div>

<footer class="py-4 text-center">
  <div class="container small">© 2025 TermGems+. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
