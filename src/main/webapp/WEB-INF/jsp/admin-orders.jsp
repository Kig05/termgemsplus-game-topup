<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Orders - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
  <style>
    :root{
      --bg-1:#0b0614; --bg-2:#150a22; --text:#e7e3ee; --muted:#b9a9c9; --border:rgba(255,255,255,.08);
      --pink:#ff2bb3; --pink-2:#ff6bd8;
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

    /* NAVBAR */
    .neon-nav{position:sticky;top:0;z-index:1030;background:rgba(12,6,18,.78);backdrop-filter:blur(10px);border-bottom:1px solid var(--border);}
    .brand-badge{display:flex;align-items:center;gap:.6rem;color:#fff;font-weight:800;}
    .brand-logo{width:34px;height:34px;border-radius:10px;display:grid;place-items:center;color:#fff;
      background:radial-gradient(120% 120% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%);}
    .navbar .nav-link{color:#b9a9c9;font-weight:700;position:relative;padding:.9rem .9rem;}
    .navbar .nav-link:hover,.navbar .nav-link.active{color:#fff;}
    .navbar .nav-link::after{content:"";position:absolute;left:14px;right:14px;bottom:.35rem;height:2px;
      background:linear-gradient(90deg,var(--pink),var(--pink-2));transform:scaleX(0);transform-origin:left;transition:transform .2s ease;}
    .navbar .nav-link:hover::after,.navbar .nav-link.active::after{transform:scaleX(1);}

    .btn-neon{
      color:#fff;font-weight:800;border-radius:12px;padding:.4rem .9rem;border:2px solid var(--pink);
      box-shadow:0 0 0 3px rgba(255,43,179,.15),0 0 18px rgba(255,43,179,.35) inset;
      background:linear-gradient(180deg,rgba(255,255,255,.02),rgba(255,255,255,.04));
    }
    .btn-neon:hover{color:#160422;background:linear-gradient(90deg,var(--pink),var(--pink-2));box-shadow:0 10px 26px rgba(255,43,179,.35);}

    /* HEADER */
    .page-header{padding:2rem 0 1.3rem;border-bottom:1px solid var(--border);margin-bottom:1rem;}
    .text-soft{color:#cbbadf;}

    /* PANELS */
    .panel{background:linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.03));
      border:1px solid rgba(255,255,255,.14);border-radius:18px;box-shadow:0 16px 44px rgba(0,0,0,.45);}

    /* ===== TABLE (Dark + White text) ===== */
    .table-dark-neon{
      color:#ffffff !important;
      --bs-table-bg: rgba(26,14,43,.55);
      --bs-table-striped-bg: rgba(255,255,255,.03);
      --bs-table-hover-bg: rgba(255,255,255,.06);
      --bs-table-border-color: rgba(255,255,255,.08);
      background:transparent;
    }
    .table-dark-neon>:not(caption)>*>*{
      background:transparent !important;
      color:#ffffff !important;
      box-shadow:none !important;
    }
    .table-dark-neon thead{
      background:linear-gradient(180deg, rgba(255,255,255,.08), rgba(255,255,255,.02));
      color:#f5f3ff !important;
    }
    .table-dark-neon tbody tr:hover{
      background:rgba(255,255,255,.08) !important;
      transition:background .2s ease;
    }

    /* Code text (Game User ID) ให้กลืนกับธีม */
    code{background:rgba(255,255,255,.08); color:#ff6bd8; padding:.12rem .35rem; border-radius:6px;}

    /* ===== Status neon colors ===== */
    .status{font-weight:800;letter-spacing:.3px;text-shadow:0 0 6px rgba(255,255,255,.12);}
    .status.pending{color:#ffb84d;text-shadow:0 0 8px rgba(255,184,77,.4);}
    .status.processing{color:#45b6ff;text-shadow:0 0 8px rgba(69,182,255,.35);}
    .status.completed{color:#5eff9c;text-shadow:0 0 8px rgba(94,255,156,.35);}
    .status.cancelled{color:#ff6b8a;text-shadow:0 0 8px rgba(255,107,138,.35);}

    .filter-btn{border-radius:999px;padding:.45rem 1rem;}
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg neon-nav" id="mainNav">
  <div class="container">
    <a class="navbar-brand brand-badge" href="${cp}/admin/dashboard"><span class="brand-logo"><i class="fa-solid fa-shield-halved"></i></span>Admin Panel</a>
    <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu"><span class="navbar-toggler-icon"></span></button>
    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ms-4">
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/dashboard"><i class="fa-solid fa-gauge-high me-1"></i>Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/games"><i class="fa-solid fa-gamepad me-1"></i>Games</a></li>
        <li class="nav-item"><a class="nav-link active" href="${cp}/admin/orders"><i class="fa-solid fa-cart-shopping me-1"></i>Orders</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/users"><i class="fa-solid fa-users me-1"></i>Users</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/admin-report"><i class="fa-solid fa-bug me-1"></i>Reports</a></li>
      </ul>
      <div class="ms-auto d-flex"><a href="${cp}/logout" class="btn btn-neon">Logout</a></div>
    </div>
  </div>
</nav>

<header class="page-header">
  <div class="container">
    <h1 class="m-0 fw-bold"><i class="fa-solid fa-cart-shopping me-2"></i>Manage Orders</h1>
    <div class="text-soft">ดูและจัดการคำสั่งเติมเกมทั้งหมด</div>
  </div>
</header>

<main class="container pb-5">
  <c:if test="${not empty success}">
    <div class="alert alert-success border-0" role="alert"><i class="fa-regular fa-circle-check me-2"></i>${success}</div>
  </c:if>

  <!-- FILTER -->
  <div class="mb-3 d-flex flex-wrap gap-2">
    <a href="${cp}/admin/orders" class="btn ${empty selectedStatus ? 'btn-neon' : 'btn-outline-light'} filter-btn">ทั้งหมด</a>
    <a href="${cp}/admin/orders?status=pending" class="btn ${selectedStatus eq 'pending' ? 'btn-warning' : 'btn-outline-warning'} filter-btn">รอดำเนินการ</a>
    <a href="${cp}/admin/orders?status=processing" class="btn ${selectedStatus eq 'processing' ? 'btn-info' : 'btn-outline-info'} filter-btn">กำลังดำเนินการ</a>
    <a href="${cp}/admin/orders?status=completed" class="btn ${selectedStatus eq 'completed' ? 'btn-success' : 'btn-outline-success'} filter-btn">เสร็จสิ้น</a>
  </div>

  <div class="panel">
    <div class="p-3 border-bottom" style="border-color:var(--border)!important;">
      <h5 class="m-0 fw-bold"><i class="fa-solid fa-list me-2"></i>Orders List (${orders.size()})</h5>
    </div>
    <div class="table-responsive p-2">
      <table class="table table-dark-neon align-middle mb-0">
        <thead>
          <tr>
            <th>Order ID</th><th>User</th><th>Game</th><th>Package</th><th>Game User ID</th>
            <th class="text-end">Amount</th><th>Status</th><th>Date</th><th>Actions</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach items="${orders}" var="order">
          <tr>
            <td><strong>#${order.id}</strong></td>
            <td><i class="fa-regular fa-user me-1"></i>${order.user.username}<br><small class="text-soft">${order.user.email}</small></td>
            <td><strong>${order.game.name}</strong><br><small class="text-soft">${order.game.category}</small></td>
            <td>${order.packageName}</td>
            <td><code>${order.gameUserId}</code><br><c:if test="${not empty order.gameServerName}"><small class="text-soft">${order.gameServerName}</small></c:if></td>
            <td class="text-end">฿<fmt:formatNumber value="${order.amount}" pattern="#,##0.00"/></td>
            <td>
              <c:choose>
                <c:when test="${order.status eq 'pending'}"><span class="status pending">รอดำเนินการ. . .</span></c:when>
                <c:when test="${order.status eq 'processing'}"><span class="status processing">กำลังดำเนินการ . . .</span></c:when>
                <c:when test="${order.status eq 'completed'}"><span class="status completed">เสร็จสิ้น!</span></c:when>
                <c:otherwise><span class="status cancelled">Cancelled</span></c:otherwise>
              </c:choose>
            </td>
            <td>${order.createdAt}</td>
            <td>
              <c:if test="${order.status ne 'completed' and order.status ne 'cancelled'}">
                <div class="btn-group">
                  <button type="button" class="btn btn-sm btn-neon dropdown-toggle" data-bs-toggle="dropdown">อัปเดตข้อมูล</button>
                  <ul class="dropdown-menu dropdown-menu-dark">
                    <li>
                      <form action="${cp}/admin/orders/update-status/${order.id}" method="post">
                        <input type="hidden" name="status" value="processing">
                        <button type="submit" class="dropdown-item"><i class="fa-solid fa-spinner me-2"></i>กำลังดำเนินการ</button>
                      </form>
                    </li>
                    <li>
                      <form action="${cp}/admin/orders/update-status/${order.id}" method="post">
                        <input type="hidden" name="status" value="completed">
                        <button type="submit" class="dropdown-item"><i class="fa-solid fa-check me-2"></i>เสร็จสิ้น</button>
                      </form>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li>
                      <form action="${cp}/admin/orders/update-status/${order.id}" method="post" onsubmit="return confirm('Cancel this order?');">
                        <input type="hidden" name="status" value="cancelled">
                        <button type="submit" class="dropdown-item text-danger"><i class="fa-solid fa-ban me-2"></i>ยกเลิก!</button>
                      </form>
                    </li>
                  </ul>
                </div>
              </c:if>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</main>

<footer class="py-4 mt-5 text-center">
  <div class="container small text-soft">© 2025 TermGems+ Admin Panel. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
