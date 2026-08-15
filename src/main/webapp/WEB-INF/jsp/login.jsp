<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>เข้าสู่ระบบ — TermGems+</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    :root{
      --bg-1:#0b0614; --bg-2:#150a22; --text:#e7e3ee; --muted:#b9a9c9;
      --border:rgba(255,255,255,.08);
      --pink:#ff2bb3; --pink-2:#ff6bd8;
      --nav-bg: rgba(12, 6, 18, .75); --nav-bg-scrolled: rgba(12, 6, 18, .92);
    }
    body{
      color:var(--text);
      background:
        radial-gradient(1200px 600px at -10% -20%, #3b0c59 0%, transparent 60%),
        radial-gradient(900px 500px at 110% -10%, #27104d 0%, transparent 55%),
        radial-gradient(1200px 700px at 90% 120%, #140a2d 0%, transparent 65%),
        linear-gradient(180deg, var(--bg-2), var(--bg-1));
      min-height:100vh;
      display:flex; flex-direction:column;
    }

    /* NAVBAR (เหมือนหน้า Home) */
    .navbar.neon-nav{position:sticky;top:0;z-index:1030;background:var(--nav-bg);backdrop-filter:blur(10px);border-bottom:1px solid var(--border);transition:background .25s ease,box-shadow .25s ease,padding .25s ease;}
    .navbar.neon-nav.stuck{background:var(--nav-bg-scrolled);box-shadow:0 10px 30px rgba(0,0,0,.35);padding-top:.35rem;padding-bottom:.35rem;}
    .brand-badge{display:flex;align-items:center;gap:.6rem;color:#fff;font-weight:800;}
    .brand-logo{width:34px;height:34px;border-radius:10px;display:grid;place-items:center;color:#fff;background:radial-gradient(120% 120% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%);}
    .navbar .nav-link{color:#b9a9c9;font-weight:700;position:relative;padding:.9rem .9rem;}
    .navbar .nav-link:hover,.navbar .nav-link.active{color:#fff;}
    .navbar .nav-link::after{content:"";position:absolute;left:14px;right:14px;bottom:.35rem;height:2px;background:linear-gradient(90deg,var(--pink),var(--pink-2));transform:scaleX(0);transform-origin:left;transition:transform .2s ease;box-shadow:0 0 8px rgba(255,43,179,.6);}
    .navbar .nav-link:hover::after,.navbar .nav-link.active::after{transform:scaleX(1);}
    .search-wrap{background:rgba(255,255,255,.06);border:1px solid var(--border);border-radius:12px;padding:.35rem .7rem;display:flex;align-items:center;gap:.5rem;min-width:260px;}
    .search-wrap input{background:transparent;border:0;outline:none;color:var(--text);width:100%;}
    .search-wrap input::placeholder{color:#9b8fb1;}
    .btn-neon{color:#fff;font-weight:800;border-radius:12px;padding:.5rem .9rem;border:2px solid var(--pink);box-shadow:0 0 0 3px rgba(255,43,179,.15),0 0 18px rgba(255,43,179,.35) inset;background:linear-gradient(180deg,rgba(255,255,255,.02),rgba(255,255,255,.04));transition:.3s;}
    .btn-neon:hover{color:#160422;background:linear-gradient(90deg,var(--pink),var(--pink-2));box-shadow:0 10px 26px rgba(255,43,179,.35);}

    /* AUTH CARD */
    .auth-wrap{flex:1;display:grid;place-items:center;padding:40px 14px;}
    .auth-card{
      width:100%; max-width:480px;
      background:linear-gradient(180deg, rgba(255,255,255,.08), rgba(255,255,255,.04));
      border:1px solid rgba(255,255,255,.14);
      border-radius:24px; backdrop-filter: blur(12px);
      box-shadow:0 20px 46px rgba(0,0,0,.5); padding:22px 18px;
    }
    .auth-head{
      display:flex; flex-direction:column; align-items:center; text-align:center; gap:.4rem; margin-bottom: .75rem;
    }
    .logo-badge{width:56px;height:56px;border-radius:16px;display:grid;place-items:center;
      background:radial-gradient(120% 120% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%);}
    label{font-weight:700;color:#d7c9ef;}
    .form-control{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.15);color:#fff;}
    .form-control::placeholder{color:#bcaed6;}
    .form-control:focus{border-color:var(--pink);box-shadow:0 0 0 .2rem rgba(255,43,179,.15);}
    .btn-topup-light{display:block;width:100%;background:linear-gradient(90deg,#ff2bb3,#ff6bd8);border:0;border-radius:14px;padding:.85rem 1rem;font-weight:900;color:#160422;box-shadow:0 0 22px rgba(255,43,179,.35);transition:transform .15s ease, opacity .15s ease;}
    .btn-topup-light:hover{opacity:.95;transform:translateY(-2px);}
    .muted{color:#b9a9c9;}
    .divider{height:1px;background:linear-gradient(90deg,transparent,rgba(255,255,255,.2),transparent);margin:18px 0;}
    .link-soft{color:#ffbaf0;text-decoration:none;font-weight:700;}
    .link-soft:hover{color:#160422;background:linear-gradient(90deg,#ff2bb3,#ff6bd8);-webkit-background-clip:text;background-clip:text;-webkit-text-fill-color:transparent;}
  </style>
</head>
<body>

<!-- CONTENT -->
<div class="auth-wrap">
  <div class="auth-card">
    <div class="auth-head">
      <div class="logo-badge"><i class="fa-solid fa-gamepad fa-lg text-white"></i></div>
      <h3 class="mb-0 fw-800">เข้าสู่ระบบ</h3>
      <div class="muted">ยินดีต้อนรับกลับเข้าสู่ TermGems+</div>
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

    <form action="${cp}/login" method="post" class="mt-2" id="loginForm">
      <div class="mb-3">
        <label for="username"><i class="fa-regular fa-user me-1"></i> ชื่อผู้ใช้ / อีเมล</label>
        <input type="text" class="form-control" id="username" name="username" placeholder="เช่น gamerz_01 หรือ you@mail.com" required autofocus>
      </div>
      <div class="mb-2">
        <label for="password"><i class="fa-solid fa-lock me-1"></i> รหัสผ่าน</label>
        <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
      </div>
      <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="form-check">
          <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
          <label class="form-check-label muted" for="rememberMe">จำฉันไว้</label>
        </div>
      </div>

      <button type="submit" class="btn-topup-light">
        <i class="fa-solid fa-right-to-bracket me-2"></i> เข้าสู่ระบบ
      </button>
    </form>

    <div class="divider"></div>

    <div class="text-center">
      <span class="muted">ยังไม่มีบัญชี?</span>
      <a href="${cp}/register" class="link-soft ms-1">สมัครสมาชิก</a>
    </div>
  </div>
</div>

<footer class="py-4 text-center">
  <div class="container small">© 2025 TermGems+. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // sticky nav
  (function(){const nav=document.getElementById('mainNav');const onScroll=()=>{window.scrollY>12?nav.classList.add('stuck'):nav.classList.remove('stuck');};onScroll();window.addEventListener('scroll',onScroll,{passive:true});})();
  // remember me (localStorage)
  window.addEventListener('DOMContentLoaded', function() {
      const savedUsername = localStorage.getItem('savedUsername');
      if (savedUsername) {
          document.getElementById('username').value = savedUsername;
          document.getElementById('rememberMe').checked = true;
      }
  });
  document.getElementById('loginForm').addEventListener('submit', function() {
      const rememberMe = document.getElementById('rememberMe').checked;
      const username = document.getElementById('username').value;
      rememberMe ? localStorage.setItem('savedUsername', username) : localStorage.removeItem('savedUsername');
  });
</script>
</body>
</html>
