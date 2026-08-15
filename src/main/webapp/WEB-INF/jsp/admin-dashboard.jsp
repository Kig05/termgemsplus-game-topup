<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Dashboard - TermGems+</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
  <style>
    :root{
      --bg-1:#0b0614; --bg-2:#150a22; --text:#ffffff; --muted:#b9a9c9;
      --border:rgba(255,255,255,.08);
      --pink:#ff2bb3; --pink-2:#ff6bd8; --violet:#7c3aed;
      --card:#11091d; --card-2:#1a0e2b;
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
    .navbar.neon-nav{
      position:sticky;top:0;z-index:1030;
      background:rgba(12,6,18,.78);
      backdrop-filter:blur(10px);
      border-bottom:1px solid var(--border);
      transition:background .2s ease,box-shadow .2s ease,padding .2s ease;
    }
    .navbar.neon-nav.stuck{ background:rgba(12,6,18,.92); box-shadow:0 10px 30px rgba(0,0,0,.35); }
    .brand-badge{display:flex;align-items:center;gap:.6rem;color:#fff;font-weight:800;}
    .brand-logo{
      width:34px;height:34px;border-radius:10px;display:grid;place-items:center;color:#fff;
      background:radial-gradient(120% 120% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%);
    }
    .navbar .nav-link{color:#b9a9c9;font-weight:700;position:relative;padding:.9rem .9rem;}
    .navbar .nav-link:hover,.navbar .nav-link.active{color:#fff;}
    .navbar .nav-link::after{
      content:"";position:absolute;left:14px;right:14px;bottom:.35rem;height:2px;
      background:linear-gradient(90deg,var(--pink),var(--pink-2));
      transform:scaleX(0);transform-origin:left;transition:transform .2s ease;
      box-shadow:0 0 8px rgba(255,43,179,.6);
    }
    .navbar .nav-link:hover::after,.navbar .nav-link.active::after{transform:scaleX(1);}
    .btn-neon{
      color:#fff;font-weight:800;border-radius:12px;padding:.5rem .9rem;border:2px solid var(--pink);
      box-shadow:0 0 0 3px rgba(255,43,179,.15),0 0 18px rgba(255,43,179,.35) inset;
      background:linear-gradient(180deg,rgba(255,255,255,.02),rgba(255,255,255,.04));transition:.25s;
    }
    .btn-neon:hover{ color:#160422;background:linear-gradient(90deg,var(--pink),var(--pink-2));box-shadow:0 10px 26px rgba(255,43,179,.35); }

    /* HEADER */
    .page-header{
      padding:2.2rem 0 1.6rem;border-bottom:1px solid var(--border); margin-bottom:1.2rem;
      background:linear-gradient(180deg, rgba(255,255,255,.02), rgba(255,255,255,.00));
    }
    .title-chip{width:38px;height:38px;border-radius:10px;display:grid;place-items:center;
      background:linear-gradient(145deg,#6b27d1,#24113f); box-shadow:0 10px 24px rgba(124,58,237,.35);}

    /* PANEL & STAT */
    .panel{
      background:linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.03));
      border:1px solid rgba(255,255,255,.14); border-radius:18px; box-shadow:0 16px 44px rgba(0,0,0,.45);
    }
    .stat-card{ padding:18px;border-radius:18px; border:1px solid rgba(255,255,255,.14); height:100%; }
    .stat-num{ font-weight:900;font-size:2.2rem; }

    /* ===== TABLE (dark theme + white text) ===== */
    .panel .table-responsive{ background:transparent; border-radius:0 0 18px 18px; }
    .table-dark-neon {
      color: #ffffff !important;
      --bs-table-bg: rgba(26,14,43,.55);
      --bs-table-striped-bg: rgba(255,255,255,.03);
      --bs-table-hover-bg: rgba(255,255,255,.05);
      --bs-table-border-color: rgba(255,255,255,.08);
      background: transparent;
    }
    .table-dark-neon>:not(caption)>*>* {
      background: transparent !important;
      color: #ffffff !important;
      box-shadow: none !important;
    }
    .table-dark-neon thead {
      background: linear-gradient(180deg, rgba(255,255,255,.08), rgba(255,255,255,.02));
      color: #f5f3ff !important;
    }
    .table-dark-neon tbody tr:hover {
      background: rgba(255,255,255,.08) !important;
      transition: background .2s ease;
    }

    /* Recent header + button */
    .recent-header{
      padding:.9rem 1rem;
      display:flex;align-items:center;justify-content:space-between;
      border-bottom:1px solid var(--border);
      background:rgba(255,255,255,.02);
      border-top-left-radius:18px;border-top-right-radius:18px;
    }
    .btn-viewall{
      padding:.35rem .8rem;border-radius:12px;font-weight:800;
      border:1px solid rgba(255,255,255,.18);
      background:rgba(255,255,255,.06);color:#fff;text-decoration:none;
    }
    .btn-viewall:hover{ background:rgba(255,255,255,.12); }

    /* Status สีเข้าธีม */
    .status {
      font-weight: 800;
      letter-spacing: .3px;
      text-shadow: 0 0 6px rgba(255,255,255,.12);
    }
    .status.pending {
      color: #ffb84d;
      text-shadow: 0 0 8px rgba(255,184,77,.4);
    }
    .status.processing {
      color: #45b6ff;
      text-shadow: 0 0 8px rgba(69,182,255,.35);
    }
    .status.completed {
      color: #5eff9c;
      text-shadow: 0 0 8px rgba(94,255,156,.35);
    }
    .status.cancelled {
      color: #ff6b8a;
      text-shadow: 0 0 8px rgba(255,107,138,.35);
    }

    footer{ border-top:1px solid var(--border); color:var(--muted); }
  </style>
</head>
<body>
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg neon-nav" id="mainNav">
  <div class="container">
    <a class="navbar-brand brand-badge" href="${cp}/admin/dashboard">
      <span class="brand-logo"><i class="fa-solid fa-shield-halved"></i></span>Admin Panel
    </a>
    <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ms-4">
        <li class="nav-item"><a class="nav-link active" href="${cp}/admin/dashboard"><i class="fa-solid fa-gauge-high me-1"></i>Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/games"><i class="fa-solid fa-gamepad me-1"></i>Games</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/orders"><i class="fa-solid fa-cart-shopping me-1"></i>Orders</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/users"><i class="fa-solid fa-users me-1"></i>Users</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/admin-report"><i class="fa-solid fa-bug me-1"></i>Reports</a></li>
      </ul>
      <div class="ms-auto d-flex">
        <a href="${cp}/logout" class="btn btn-neon"><i class="fa-solid fa-right-from-bracket me-1"></i>Logout</a>
      </div>
    </div>
  </div>
</nav>

<!-- HEADER -->
<header class="page-header">
  <div class="container">
    <div class="d-flex align-items-center justify-content-between flex-wrap">
      <div class="d-flex align-items-center gap-3">
        <div class="title-chip text-white"><i class="fa-solid fa-gauge-high"></i></div>
        <div>
          <h1 class="m-0 fw-bold">Dashboard</h1>
          <div class="text-soft">ยินดีต้อนรับกลับ, ${user.fullName}</div>
        </div>
      </div>
      <div class="d-flex gap-2">
        <a href="${cp}/admin/orders?status=pending" class="btn btn-neon"><i class="fa-regular fa-clock me-1"></i> คำสั่งซื้อค้าง</a>
      </div>
    </div>
  </div>
</header>

<main class="container pb-5">
  <!-- STAT -->
  <div class="row g-3 mb-3">
    <div class="col-6 col-md-3">
      <div class="stat-card panel">
        <div class="d-flex align-items-center justify-content-between">
          <div class="text-soft fw-bold">Users</div>
          <i class="fa-solid fa-users text-soft"></i>
        </div>
        <div class="stat-num mt-1">${totalUsers}</div>
      </div>
    </div>
    <div class="col-6 col-md-3">
      <div class="stat-card panel">
        <div class="d-flex align-items-center justify-content-between">
          <div class="text-soft fw-bold">Games</div>
          <i class="fa-solid fa-gamepad text-soft"></i>
        </div>
        <div class="stat-num mt-1">${totalGames}</div>
      </div>
    </div>
    <div class="col-6 col-md-3">
      <div class="stat-card panel">
        <div class="d-flex align-items-center justify-content-between">
          <div class="text-soft fw-bold">Orders</div>
          <i class="fa-solid fa-cart-shopping text-soft"></i>
        </div>
        <div class="stat-num mt-1">${totalOrders}</div>
      </div>
    </div>
    <div class="col-6 col-md-3">
      <div class="stat-card panel">
        <div class="d-flex align-items-center justify-content-between">
          <div class="text-soft fw-bold">Revenue</div>
          <i class="fa-solid fa-sack-dollar text-soft"></i>
        </div>
        <div class="stat-num mt-1">฿<fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></div>
      </div>
    </div>
  </div>

  <!-- ORDER STATUS -->
  <div class="row g-3 mb-4">
    <div class="col-md-4">
      <div class="panel p-4 text-center">
        <i class="fa-regular fa-clock mb-2"></i>
        <div class="display-6 fw-bold">${pendingOrders}</div>
        <div class="text-soft">ออเดอร์ที่รอดำเนินการ</div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="panel p-4 text-center">
        <i class="fa-solid fa-spinner mb-2"></i>
        <div class="display-6 fw-bold">${processingOrders}</div>
        <div class="text-soft">ออเดอร์ที่กำลังดำเนินการ</div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="panel p-4 text-center">
        <i class="fa-regular fa-circle-check mb-2"></i>
        <div class="display-6 fw-bold">${completedOrders}</div>
        <div class="text-soft">ออเดอร์ที่ดำเนินการเสร็จสิ้น</div>
      </div>
    </div>
  </div>

  <!-- RECENT ORDERS -->
  <div class="panel">
    <div class="recent-header">
      <h5 class="m-0 fw-bold">
        <i class="fa-solid fa-clock-rotate-left me-2"></i>คำสั่งซื้อล่าสุด
      </h5>
      <a href="${cp}/admin/orders" class="btn-viewall">View All</a>
    </div>

    <div class="p-0">
      <div class="table-responsive">
        <table class="table table-dark-neon align-middle mb-0">
          <thead>
            <tr>
              <th>Order ID</th>
              <th>User</th>
              <th>Game</th>
              <th>Package</th>
              <th class="text-end">Amount</th>
              <th>Status</th>
              <th>Date</th>
            </tr>
          </thead>
          <tbody>
          <c:forEach items="${recentOrders}" var="order">
            <tr>
              <td><strong>#${order.id}</strong></td>
              <td>${order.user.username}</td>
              <td>${order.game.name}</td>
              <td>${order.packageName}</td>
              <td class="text-end">฿<fmt:formatNumber value="${order.amount}" pattern="#,##0.00"/></td>
              <td>
                <c:choose>
                  <c:when test="${order.status eq 'pending'}"><span class="status pending">รอดำเนินการ. . .</span></c:when>
                  <c:when test="${order.status eq 'processing'}"><span class="status processing">กำลังดำเนินการ. . .</span></c:when>
                  <c:when test="${order.status eq 'completed'}"><span class="status completed">เสร็จสิ้น!</span></c:when>
                  <c:otherwise><span class="status cancelled">ยกเลิก</span></c:otherwise>
                </c:choose>
              </td>
              <td>${order.createdAt}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</main>

<footer class="py-4 mt-5 text-center">
  <div class="container small text-soft">© 2025 TermGems+ Admin Panel. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  (function(){
    const nav=document.getElementById('mainNav');
    const onScroll=()=>{window.scrollY>12?nav.classList.add('stuck'):nav.classList.remove('stuck');};
    onScroll();window.addEventListener('scroll',onScroll,{passive:true});
  })();
</script>
</body>
</html>
