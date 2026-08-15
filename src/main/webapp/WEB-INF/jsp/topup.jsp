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
  <title>TermGems+ — เติม ${empty game ? 'เกม' : game.name}</title>
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
    }

    /* NAVBAR */
    .navbar.neon-nav{
      position:sticky;top:0;z-index:1030;
      background:var(--nav-bg);
      backdrop-filter:blur(10px);
      border-bottom:1px solid var(--border);
      transition:background .25s ease,box-shadow .25s ease,padding .25s ease;
    }
    .navbar.neon-nav.stuck{ background:var(--nav-bg-scrolled); box-shadow:0 10px 30px rgba(0,0,0,.35); padding-block:.35rem;}
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
    .search-wrap{
      background:rgba(255,255,255,.06);border:1px solid var(--border);
      border-radius:12px;padding:.35rem .7rem;display:flex;align-items:center;gap:.5rem;min-width:280px;
    }
    .search-wrap input{background:transparent;border:0;outline:none;color:var(--text);width:100%;}
    .search-wrap input::placeholder{color:#9b8fb1;}
    .btn-neon{
      color:#fff;font-weight:800;border-radius:12px;padding:.5rem .9rem;
      border:2px solid var(--pink);
      box-shadow:0 0 0 3px rgba(255,43,179,.15),0 0 18px rgba(255,43,179,.35) inset;
      background:linear-gradient(180deg,rgba(255,255,255,.02),rgba(255,255,255,.04));
      transition:.3s;
    }
    .btn-neon:hover{color:#160422;background:linear-gradient(90deg,var(--pink),var(--pink-2));box-shadow:0 10px 26px rgba(255,43,179,.35);}

    /* ===== HERO IMAGE (แสดงเต็มภาพ ไม่ตัดขอบ) ===== */
    .game-hero{ margin-top:1.6rem; }
    .cover-wrap{
      position:relative;
      border-radius:22px;
      overflow:hidden;
      height: clamp(280px, 42vh, 480px);
      background:#000;
      box-shadow:0 20px 50px rgba(0,0,0,.45);
    }
    /* เปลี่ยนเป็น contain + จัดกึ่งกลาง เพื่อให้เห็นครบทั้งภาพ */
    .cover-img{
      width:100%; height:100%; display:block;
      object-fit:contain;                /* <<< เปลี่ยนจาก cover เป็น contain */
      object-position:center center;     /* จัดกึ่งกลางภาพ */
      background:#000;                   /* เผื่อมีขอบดำ (letterbox) */
      filter: brightness(.98) contrast(1.08);
      transition: filter .8s ease;       /* ตัดการซูมเพื่อไม่ให้ล้นกรอบ */
    }
    .cover-wrap:hover .cover-img{ filter:brightness(1.04); }
    .cover-overlay{
      position:absolute; inset:0; display:flex; align-items:end;
      background:linear-gradient(180deg, rgba(10,0,25,0.00) 55%, rgba(10,0,25,0.78) 100%);
    }
    .game-info{ padding:1.6rem 2rem; }
    .game-title{ font-weight:900; font-size:2rem; color:#fff; text-shadow:0 0 14px rgba(0,0,0,.6); margin:0; }
    .game-sub{ color:#d8c8ef; font-size:1rem; text-shadow:0 0 10px rgba(0,0,0,.5); max-width:760px; margin:.35rem 0 0; }

    @media (max-width:768px){
      .cover-wrap{ height:260px; }
      .game-info{ padding:1.1rem 1.25rem; }
      .game-title{ font-size:1.5rem; }
      .game-sub{ font-size:.95rem; }
    }

    /* ===== PANELS / CARDS ===== */
    .actions-panel{
      position:relative; padding:18px; border-radius:26px;
      background:linear-gradient(180deg, rgba(255,255,255,.05), rgba(255,255,255,.02));
      border:1px solid rgba(255,255,255,.12);
      box-shadow:0 18px 44px rgba(0,0,0,.45);
      height:100%;
    }
    .panel-header{display:flex; align-items:center; gap:.6rem; margin-bottom:.8rem;}
    .panel-header .dot{width:8px; height:8px; border-radius:999px; background:linear-gradient(90deg,#ff2bb3,#ff6bd8); box-shadow:0 0 10px rgba(255,43,179,.8);}
    .text-soft{ color:#cbbadf; }

    /* ===== PACKAGE CARD ===== */
    .pkg-card{
      border-radius:20px;
      background:linear-gradient(180deg,rgba(255,255,255,.06),rgba(255,255,255,.02));
      border:2px solid rgba(229,0,255,.25);
      box-shadow:0 8px 28px rgba(124,58,237,.18);
      padding:14px; transition:.22s; cursor:pointer; position:relative;
      height:100%;
    }
    .pkg-card:hover{transform:translateY(-6px);border-color:rgba(229,0,255,.55);}
    .pkg-card.selected{border-color:#39ffb6; box-shadow:0 0 24px rgba(57,255,182,.35);}
    .pkg-thumb{width:100%;height:120px;object-fit:cover;object-position:center;border-radius:14px;margin-bottom:.6rem;background:#0d0717;}
    .pkg-name{font-weight:800;}
    .pkg-price{font-weight:900;font-size:1.15rem;color:#fff;}
    .pkg-desc{color:#d9c8ef;font-size:.9rem;}

    /* ===== BALANCE / SUMMARY ===== */
    .balance-card{background:linear-gradient(180deg, rgba(255,255,255,.08), rgba(255,255,255,.04));border:1px solid rgba(255,255,255,.14);backdrop-filter:blur(12px);border-radius:24px;box-shadow:0 20px 46px rgba(0,0,0,.5);padding:22px 18px;height:100%;}
    .balance-amount{font-weight:900;font-size:2rem;color:#fff;}
    .btn-topup-light{display:block;width:100%;background:linear-gradient(90deg,#ff2bb3,#ff6bd8);border:0;border-radius:14px;padding:.85rem 1rem;font-weight:900;color:#160422;box-shadow:0 0 22px rgba(255,43,179,.35);transition:transform .15s ease, opacity .15s ease;}
    .btn-topup-light:hover{opacity:.95;transform:translateY(-2px);}

    .form-control{
      background:rgba(255,255,255,.06); border:1px solid rgba(255,255,255,.18); color:#fff;
    }
    .form-control::placeholder{ color:#b7a9cc; }
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
        <li class="nav-item"><a class="nav-link" href="${cp}/games">เกมทั้งหมด</a></li>
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


<!-- ===== HERO COVER ===== -->
<section class="game-hero">
  <div class="container">
    <div class="cover-wrap">
      <c:choose>
        <c:when test="${not empty game.imageUrl}">
          <img src="${game.imageUrl}" alt="${game.name}" class="cover-img">
        </c:when>
        <c:otherwise>
          <img src="https://picsum.photos/1600/700?blur=2" alt="cover" class="cover-img">
        </c:otherwise>
      </c:choose>

      <div class="cover-overlay">
        <div class="game-info">
          <h1 class="game-title">
            <i class="fa-solid fa-gamepad me-2" style="color:#ff6bd8;"></i>
            ${empty game ? 'เกม' : game.name}
          </h1>
          <p class="game-sub">
            ${empty game.description ? '— ไม่มีคำอธิบายเกม —' : game.description}
          </p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ===== MAIN CONTENT (เดิมทั้งหมด) ===== -->
<section class="py-4">
  <div class="container">
    <div class="row g-4">
      <div class="col-lg-8">
        <div class="actions-panel">
          <div class="panel-header">
            <span class="dot"></span><div class="fw-bold text-soft">เลือกแพ็กเกจ</div>
          </div>

          <c:choose>
            <c:when test="${empty packages}">
              <div class="alert alert-warning mb-0">
                <i class="fa-solid fa-circle-exclamation me-1"></i>ยังไม่มีแพ็กเกจสำหรับเกมนี้
              </div>
            </c:when>
            <c:otherwise>
              <div class="row g-3">
                <c:forEach items="${packages}" var="pkg">
                  <div class="col-md-6">
                    <div class="pkg-card" data-id="${pkg.id}" data-name="${fn:escapeXml(pkg.name)}" data-price="${pkg.price}" onclick="selectPackage(event,this)">
                      <c:if test="${not empty pkg.imageUrl}">
                        <img src="${pkg.imageUrl}" alt="${pkg.name}" class="pkg-thumb">
                      </c:if>
                      <div class="pkg-name">${pkg.name}</div>
                      <div class="pkg-price">฿<fmt:formatNumber value="${pkg.price}" pattern="#,##0.00"/></div>
                      <c:if test="${not empty pkg.description}">
                        <div class="pkg-desc">${pkg.description}</div>
                      </c:if>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

      <div class="col-lg-4">
        <div class="actions-panel">
          <div class="panel-header">
            <span class="dot"></span><div class="fw-bold text-soft">รายละเอียดการเติม</div>
          </div>

          <c:if test="${not empty error}">
            <div class="alert alert-danger"><i class="fa-solid fa-triangle-exclamation me-1"></i>${error}</div>
          </c:if>

          <form action="${cp}/topup/process" method="post" id="topupForm">
            <input type="hidden" name="gameId" value="${empty game ? '' : game.id}">
            <input type="hidden" id="packageId" name="packageId">
            <input type="hidden" id="packageName" name="packageName">
            <input type="hidden" id="amount" name="amount">

            <div class="mb-3">
              <label class="form-label fw-bold"><i class="fa-regular fa-id-badge me-1"></i>Game User ID <span class="text-danger">*</span></label>
              <input class="form-control" id="gameUserId" name="gameUserId" placeholder="เช่น 123456789" required>
            </div>

            <div class="mb-3">
              <label class="form-label fw-bold"><i class="fa-solid fa-server me-1"></i>Server (ถ้ามี)</label>
              <input class="form-control" id="gameServerName" name="gameServerName" placeholder="เช่น Asia / EU">
            </div>

            <div class="balance-card mb-3">
              <div class="balance-amount text-center">฿<span id="summaryTotal">0.00</span></div>
              <div class="text-center text-soft">รวมยอดสุทธิ</div>
            </div>

            <button class="btn-topup-light" type="submit"><i class="fa-solid fa-circle-check me-2"></i>ยืนยันการเติม</button>
            <a href="${cp}/games" class="btn btn-outline-light mt-2" style="border-color:rgba(255,255,255,.25);"><i class="fa-solid fa-arrow-left me-1"></i>กลับหน้าเกมทั้งหมด</a>
          </form>
        </div>
      </div>
    </div>
  </div>
</section>

<footer class="py-4 mt-4 text-center">
  <div class="container small">© 2025 TermGems+. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Sticky navbar
  (()=>{const nav=document.getElementById('mainNav'); const onS=()=>{window.scrollY>12?nav.classList.add('stuck'):nav.classList.remove('stuck')}; onS(); window.addEventListener('scroll',onS,{passive:true});})();

  // เลือกแพ็กเกจ
  function selectPackage(ev, el){
    document.querySelectorAll('.pkg-card').forEach(x=>x.classList.remove('selected'));
    el.classList.add('selected');
    const id=el.dataset.id, name=el.dataset.name, price=parseFloat(el.dataset.price||0);
    document.getElementById('packageId').value=id;
    document.getElementById('packageName').value=name;
    document.getElementById('amount').value=price.toFixed(2);
    document.getElementById('summaryTotal').textContent=price.toFixed(2);
  }

  // ตรวจสอบฟอร์ม
  document.getElementById('topupForm').addEventListener('submit', function(e){
    const pid=document.getElementById('packageId').value;
    const uid=(document.getElementById('gameUserId').value||'').trim();
    if(!pid){ e.preventDefault(); alert('กรุณาเลือกแพ็กเกจ'); return false; }
    if(!uid){ e.preventDefault(); alert('กรุณากรอก Game User ID'); return false; }
  });
</script>
</body>
</html>
