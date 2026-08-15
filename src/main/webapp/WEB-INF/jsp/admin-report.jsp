<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <title>รายงานการแจ้งปัญหา - Admin</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    :root{ --bg-1:#0b0614; --bg-2:#150a22; --text:#e7e3ee; --muted:#b9a9c9; --border:rgba(255,255,255,.08);
           --pink:#ff2bb3; --pink-2:#ff6bd8; }
    body{
      color:var(--text);
      background:
        radial-gradient(1200px 600px at -10% -20%, #3b0c59 0%, transparent 60%),
        radial-gradient(900px 500px at 110% -10%, #27104d 0%, transparent 55%),
        radial-gradient(1200px 700px at 90% 120%, #140a2d 0%, transparent 65%),
        linear-gradient(180deg, var(--bg-2), var(--bg-1));
      min-height:100vh;
    }
    .neon-nav{position:sticky;top:0;z-index:1030;background:rgba(12,6,18,.78);backdrop-filter:blur(10px);border-bottom:1px solid var(--border);}
    .brand-badge{display:flex;align-items:center;gap:.6rem;color:#fff;font-weight:800;}
    .brand-logo{width:34px;height:34px;border-radius:10px;display:grid;place-items:center;color:#fff;background:radial-gradient(120% 120% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%);}
    .navbar .nav-link{color:#b9a9c9;font-weight:700;position:relative;padding:.9rem .9rem;}
    .navbar .nav-link:hover,.navbar .nav-link.active{color:#fff;}
    .btn-neon{color:#fff;font-weight:800;border-radius:12px;padding:.45rem .9rem;border:2px solid var(--pink);
      box-shadow:0 0 0 3px rgba(255,43,179,.15),0 0 18px rgba(255,43,179,.35) inset;background:linear-gradient(180deg,rgba(255,255,255,.02),rgba(255,255,255,.04));}
    .btn-neon:hover{color:#160422;background:linear-gradient(90deg,var(--pink),var(--pink-2));box-shadow:0 10px 26px rgba(255,43,179,.35);}
    .page-header{padding:2rem 0 1.3rem;border-bottom:1px solid var(--border);margin-bottom:1rem;}
    .text-soft{color:#cbbadf;}
    .panel{background:linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.03));border:1px solid rgba(255,255,255,.14);border-radius:18px;box-shadow:0 16px 44px rgba(0,0,0,.45);}
    .ticket-card{
      border:1px solid rgba(255,255,255,.14); border-radius:16px; padding:16px;
      background:linear-gradient(145deg, rgba(255,255,255,.05), rgba(255,255,255,.02)); margin-bottom:14px;
    }
    .kv{display:grid;grid-template-columns:160px 1fr;gap:.35rem .9rem;}
    .kv .k{color:#cbbadf;}
    .msg{white-space:pre-wrap; background:rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.12);
         border-radius:12px; padding:12px; margin-top:8px;}
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg neon-nav">
  <div class="container">
    <a class="navbar-brand brand-badge" href="${cp}/admin/dashboard"><span class="brand-logo"><i class="fa-solid fa-shield-halved"></i></span>Admin Panel</a>
    <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu"><span class="navbar-toggler-icon"></span></button>
    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ms-4">
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/dashboard"><i class="fa-solid fa-gauge-high me-1"></i>Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/games"><i class="fa-solid fa-gamepad me-1"></i>Games</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/orders"><i class="fa-solid fa-cart-shopping me-1"></i>Orders</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/users"><i class="fa-solid fa-users me-1"></i>Users</a></li>
        <li class="nav-item"><a class="nav-link active" href="${cp}/admin/admin-report"><i class="fa-solid fa-bug me-1"></i>Reports</a></li>
      </ul>
      <div class="ms-auto d-flex"><a href="${cp}/logout" class="btn btn-neon">Logout</a></div>
    </div>
  </div>
</nav>

<header class="page-header">
  <div class="container">
    <h1 class="m-0 fw-bold"><i class="fa-solid fa-clipboard-list me-2"></i>รายการแจ้งปัญหาจากผู้ใช้</h1>
    <div class="text-soft">แสดงรายละเอียดคำร้องทั้งหมด</div>
  </div>
</header>

<main class="container pb-5">
  <div class="panel p-3">
    <c:if test="${empty tickets}">
      <div class="text-soft">ยังไม่มีรายการแจ้งปัญหา</div>
    </c:if>

    <c:forEach items="${tickets}" var="t" varStatus="vs">
      <div class="ticket-card">
        <div class="d-flex justify-content-between align-items-center mb-2">
          <div class="fw-bold">• คำร้องที่ #${t.id} | โดยคุณ ${t.name}</div>
          <div class="small text-soft"><i class="fa-regular fa-clock me-1"></i>${t.createdAt}</div>
        </div>

        <div class="kv">
          <div class="k">หัวข้อ</div><div>${t.subject}</div>
          <div class="k">หมวดหมู่</div><div>${t.category}</div>
          <div class="k">คำสั่งซื้อ</div><div>${empty t.orderId ? '-' : t.orderId}</div>
          <div class="k">อีเมล</div><div>${t.email}</div>
        </div>

        <div class="msg">${t.message}</div>
      </div>
    </c:forEach>
  </div>
</main>

<footer class="py-4 mt-5 text-center">
  <div class="container small text-soft">© 2025 TermGems+ Admin Panel. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>