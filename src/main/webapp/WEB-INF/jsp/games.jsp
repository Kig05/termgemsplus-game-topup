<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Games — TermGems+</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    :root{
      --bg-1:#0b0614; --bg-2:#150a22; --text:#e7e3ee; --muted:#b9a9c9;
      --border:rgba(255,255,255,.08); --pink:#ff2bb3; --pink-2:#ff6bd8;
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
    }

    /* NAVBAR (เหมือนหน้า Home) */
    .navbar.neon-nav{
      position:sticky; top:0; z-index:1030;
      background:var(--nav-bg); backdrop-filter:blur(10px);
      border-bottom:1px solid var(--border);
      transition:background .25s ease, box-shadow .25s ease, padding .25s ease;
    }
    .navbar.neon-nav.stuck{
      background:var(--nav-bg-scrolled);
      box-shadow:0 10px 30px rgba(0,0,0,.35);
      padding-top:.35rem; padding-bottom:.35rem;
    }
    .brand-badge{display:flex; align-items:center; gap:.6rem; color:#fff; font-weight:800;}
    .brand-logo{
      width:34px; height:34px; border-radius:10px; display:grid; place-items:center; color:#fff;
      background:radial-gradient(120% 120% at 30% 30%, #ff5bd1 0%, #7c3aed 55%, #2a0a43 100%);
    }
    .navbar .nav-link{color:#b9a9c9; font-weight:700; position:relative; padding:.9rem .9rem;}
    .navbar .nav-link:hover, .navbar .nav-link.active{color:#fff;}
    .navbar .nav-link::after{
      content:""; position:absolute; left:14px; right:14px; bottom:.35rem; height:2px;
      background:linear-gradient(90deg, var(--pink), var(--pink-2));
      transform:scaleX(0); transform-origin:left; transition:transform .2s ease;
      box-shadow:0 0 8px rgba(255,43,179,.6);
    }
    .navbar .nav-link:hover::after, .navbar .nav-link.active::after{transform:scaleX(1);}
    .search-wrap{
      background:rgba(255,255,255,.06); border:1px solid var(--border);
      border-radius:12px; padding:.35rem .7rem; display:flex; align-items:center; gap:.5rem; min-width:280px;
    }
    .search-wrap input{background:transparent; border:0; outline:none; color:var(--text); width:100%;}
    .search-wrap input::placeholder{color:#9b8fb1;}

    .btn-neon{
      color:#fff; font-weight:800; border-radius:12px; padding:.5rem .9rem;
      border:2px solid var(--pink);
      box-shadow:0 0 0 3px rgba(255,43,179,.15), 0 0 18px rgba(255,43,179,.35) inset;
      background:linear-gradient(180deg, rgba(255,255,255,.02), rgba(255,255,255,.04));
      transition:.3s;
    }
    .btn-neon:hover{
      color:#160422; background:linear-gradient(90deg, var(--pink), var(--pink-2));
      box-shadow:0 10px 26px rgba(255,43,179,.35);
    }

    /* PAGE HEADER */
    .page-header{
      padding:2.2rem 0 1.6rem;
      border-bottom:1px solid var(--border);
      background:linear-gradient(145deg, rgba(255,255,255,.04), rgba(255,255,255,.02));
      box-shadow:0 12px 40px rgba(0,0,0,.35) inset;
    }
    .page-title{
      font-weight:900; letter-spacing:.3px;
      background:linear-gradient(90deg,#fff,#ffd6f6);
      -webkit-background-clip:text; background-clip:text; color:transparent;
      text-shadow:0 0 18px rgba(255,43,179,.15);
    }
    .page-sub{color:#d7c7ef}

    /* FILTER SIDEBAR */
    .filter-card{
      border-radius:18px; border:1px solid rgba(255,255,255,.12);
      background:linear-gradient(180deg, rgba(255,255,255,.05), rgba(255,255,255,.02));
      box-shadow:0 14px 40px rgba(0,0,0,.45);
    }
    .filter-card .form-label{font-weight:800; color:#eeddff}
    .filter-card .list-group-item{
      background:transparent; color:var(--text); border:1px solid rgba(255,255,255,.08);
      margin-bottom:.5rem; border-radius:10px;
    }
    .filter-card .list-group-item.active{
      border-color:rgba(229,0,255,.55);
      background:linear-gradient(90deg, rgba(229,0,255,.18), rgba(124,58,237,.18));
      color:#fff;
      box-shadow:0 10px 26px rgba(124,58,237,.25), inset 0 0 18px rgba(229,0,255,.15);
    }
    .search-box{border-radius:12px; background:rgba(255,255,255,.06); color:#fff; border:1px solid var(--border)}
    .search-box::placeholder{color:#b8a9cc}

    /* BADGES */
    .badge-popular{
      position:absolute; top:10px; right:10px; border-radius:999px;
      background:linear-gradient(90deg,#ffea00,#ffbb00); color:#000; font-weight:900; padding:.4rem .6rem; border:0;
      box-shadow:0 6px 16px rgba(255,214,0,.35);
    }
    .category-badge{ background:linear-gradient(90deg,#7c3aed,#c084fc); color:#fff; border:0; }

    /* GAME CARD — กรอบเรืองแสงแบบในรูป */
    .game-card{
      border-radius:20px;
      background:linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.02));
      border:2px solid rgba(229,0,255,.35);
      box-shadow:
        0 0 10px rgba(255,43,179,.20),
        0 0 25px rgba(124,58,237,.25),
        inset 0 0 15px rgba(255,255,255,.04);
      overflow:hidden;
      transition:all .25s ease;
      height:100%;
      position:relative;
      cursor:pointer;
      text-decoration:none;
      color:inherit;
      display:block;
    }
    .game-card:hover{
      transform:translateY(-6px);
      border-color:rgba(229,0,255,.6);
      box-shadow:
        0 0 15px rgba(255,43,179,.35),
        0 0 35px rgba(124,58,237,.35),
        inset 0 0 20px rgba(255,255,255,.05);
      background:radial-gradient(circle at 15% 0%, rgba(255,255,255,.05), rgba(255,255,255,.01));
    }
    .game-card img{
      height:200px; width:100%; object-fit:cover;
      border-bottom:1px solid rgba(255,255,255,.1);
      transition:opacity .3s ease;
      display:block;
    }
    .game-card:hover img{ opacity:.9; }

    .game-card .card-body{padding:14px 14px 16px;}
    .btn-outline-neon{
      display:block; width:100%; border:2px solid #ff2bb3; color:#e9d7ff;
      border-radius:12px; padding:.55rem .9rem; font-weight:800; text-align:center;
    }
    .btn-outline-neon:hover{
      color:#160422; background:linear-gradient(90deg,#ff2bb3,#ff6bd8);
      box-shadow:0 10px 26px rgba(255,43,179,.35);
    }
    .count-chip{
      display:inline-block; border-radius:999px; padding:.25rem .6rem;
      border:1px solid rgba(255,255,255,.25); color:#ffd8f7; font-weight:700;
      background:linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.02));
    }

    /* FOOTER */
    footer{border-top:1px solid var(--border); color:#d8c9ee}
  </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg neon-nav" id="mainNav">
  <div class="container">
    <a class="navbar-brand brand-badge" href="${cp}/home">
      <span class="brand-logo"><i class="fa-solid fa-gem"></i></span>TermGems+
    </a>
    <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ms-4">
        <li class="nav-item"><a class="nav-link" href="${cp}/home">หน้าหลัก</a></li>
        <li class="nav-item"><a class="nav-link active" href="${cp}/games">เกมทั้งหมด</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/orders">ประวัติการเติม</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/support">ติดต่อเรา</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/profile">โปรไฟล์</a></li>
      </ul>

      <div class="ms-auto d-none d-lg-flex align-items-center gap-3">

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

<!-- PAGE HEADER -->
<header class="page-header">
  <div class="container">
    <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
      <div>
        <h1 class="page-title mb-1"><i class="fa-solid fa-gamepad me-2"></i>เกมทั้งหมด</h1>
        <div class="page-sub">เลือกเกมที่ต้องการและเติมได้ทันที — สะดวก รวดเร็ว ปลอดภัย</div>
      </div>
      <span class="count-chip"><i class="fa-solid fa-database me-1"></i>${games.size()} เกม</span>
    </div>
  </div>
</header>

<!-- CONTENT -->
<div class="container my-4">
  <div class="row g-4">
    <!-- SIDEBAR FILTER -->
    <aside class="col-lg-3">
      <div class="filter-card p-3">
        <h5 class="fw-bold mb-3"><i class="fa-solid fa-filter me-2"></i>ตัวกรอง</h5>

        <!-- ค้นหา -->
        <form action="${cp}/games" method="get" class="mb-3">
          <label class="form-label fw-bold">ค้นหาเกม</label>
          <div class="input-group">
            <input type="text" class="form-control search-box" name="search" value="${search}" placeholder="เช่น ROV, Genshin">
            <button class="btn btn-neon" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
          </div>
        </form>

        <hr class="border-secondary-subtle">

        <!-- หมวดหมู่ -->
        <div>
          <label class="form-label fw-bold">หมวดหมู่</label>
          <div class="list-group">
            <a href="${cp}/games" class="list-group-item list-group-item-action ${empty selectedCategory ? 'active' : ''}">
              <i class="fa-solid fa-th-large me-2"></i>ทั้งหมด
            </a>
            <c:forEach items="${categories}" var="cat">
              <a href="${cp}/games?category=${cat}" class="list-group-item list-group-item-action ${selectedCategory eq cat ? 'active' : ''}">
                <i class="fa-solid fa-tag me-2"></i>${cat}
              </a>
            </c:forEach>
          </div>
        </div>
      </div>
    </aside>

    <!-- GAMES GRID -->
    <main class="col-lg-9">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="mb-0">
          <c:choose>
            <c:when test="${not empty search}">
              ผลการค้นหา: "<span class="text-info">${fn:escapeXml(search)}</span>"
            </c:when>
            <c:when test="${not empty selectedCategory}">
              หมวดหมู่: <span class="text-info">${selectedCategory}</span>
            </c:when>
            <c:otherwise>ทั้งหมด</c:otherwise>
          </c:choose>
        </h4>
        <a href="${cp}/games" class="btn btn-neon px-3 py-2"><i class="fa-solid fa-rotate me-1"></i>ล้างตัวกรอง</a>
      </div>

      <c:if test="${empty games}">
        <div class="alert alert-info border-0" style="background:rgba(255,255,255,.06); color:#fff;">
          <i class="fa-regular fa-circle-question me-2"></i>ไม่พบข้อมูลเกมที่ค้นหา
        </div>
      </c:if>

      <div class="row g-4">
        <c:forEach items="${games}" var="game">
          <div class="col-md-6 col-lg-4">
            <a class="game-card" href="${cp}/topup/${game.id}">
              <div class="position-relative">
                <img src="${game.imageUrl}" alt="${game.name}">
                <c:if test="${game.popular}">
                  <span class="badge badge-popular"><i class="fa-solid fa-star me-1"></i>Popular</span>
                </c:if>
              </div>
              <div class="card-body">
                <h5 class="mb-1 fw-bold">${game.name}</h5>
                <p class="text-muted small mb-2" style="color:#cbbadf !important;">
                  <c:choose>
                    <c:when test="${not empty game.description}">${game.description}</c:when>
                    <c:otherwise>เกมนี้รองรับการเติมผ่านระบบ TermGems+ อย่างรวดเร็ว</c:otherwise>
                  </c:choose>
                </p>
                <div class="mb-3">
                  <c:forEach items="${game.categoryList}" var="cat">
                    <span class="badge category-badge me-1">${cat}</span>
                  </c:forEach>
                  <span class="badge" style="background:rgba(255,255,255,.12); color:#e9d7ff;">
                    <i class="fa-solid fa-bag-shopping me-1"></i>${game.orderCount} orders
                  </span>
                </div>
                <span class="btn-outline-neon"><i class="fa-solid fa-plus-circle me-1"></i>เติมเกม</span>
              </div>
            </a>
          </div>
        </c:forEach>
      </div>
    </main>
  </div>
</div>

<footer class="py-4 mt-5 text-center">
  <div class="container small">© 2025 TermGems+. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // เอฟเฟกต์ navbar เหมือนหน้า Home
  (function(){
    const nav = document.getElementById('mainNav');
    const onScroll = () => { window.scrollY > 12 ? nav.classList.add('stuck') : nav.classList.remove('stuck'); };
    onScroll(); window.addEventListener('scroll', onScroll, {passive:true});
  })();
</script>
</body>
</html>
