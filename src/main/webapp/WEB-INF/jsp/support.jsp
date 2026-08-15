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
  <title>TermGems+ — ติดต่อเรา (Support)</title>
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
    .navbar.neon-nav.stuck{
      background:var(--nav-bg-scrolled);
      box-shadow:0 10px 30px rgba(0,0,0,.35);
      padding-top:.35rem;padding-bottom:.35rem;
    }
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
    .btn-neon:hover{
      color:#160422;background:linear-gradient(90deg,var(--pink),var(--pink-2));
      box-shadow:0 10px 26px rgba(255,43,179,.35);
    }

    /* PAGE HEADER */
    .page-hero{ padding:2.6rem 0 1.2rem; }
    .breadcrumbs{ color:#cbbadf;font-weight:700; }
    .breadcrumbs a{ color:#ffbaf0; text-decoration:none; }
    .title-gradient{
      font-weight:900; font-size:2.1rem;
      background:linear-gradient(90deg,#fff,#ffbaf0);
      -webkit-background-clip:text; background-clip:text; color:transparent;
    }

    /* PANELS */
    .panel{
      background:linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.02));
      border:1px solid rgba(255,255,255,.14);
      border-radius:24px; box-shadow:0 20px 46px rgba(0,0,0,.5);
      padding:22px 18px; height:100%;
    }
    .panel-header{display:flex; align-items:center; gap:.6rem; margin-bottom:1rem;}
    .dot{width:8px; height:8px; border-radius:999px; background:linear-gradient(90deg,#ff2bb3,#ff6bd8); box-shadow:0 0 10px rgba(255,43,179,.8);}
    .text-soft{ color:#cbbadf; }

    /* ===== FORM: สีตัวอักษร/โฟกัส/placeholder ปรับให้อ่านง่าย ===== */
    .form-control, .form-select, textarea{
      background:rgba(255,255,255,.03)!important;
      color:#fff !important;
      border:1px solid rgba(255,255,255,.18);
      border-radius:12px;
      transition:all .25s ease;
    }
    .form-control::placeholder, textarea::placeholder{ color:#bda8d6 !important; opacity:.95; }
    .form-select{ color:#fff !important; }
    .form-select:invalid, .form-select option[disabled]{ color:#c8b7de !important; }

    .form-control:focus, .form-select:focus, textarea:focus{
      border-color:#ff6bd8 !important;
      box-shadow:0 0 0 .2rem rgba(255,107,216,.25);
      background:rgba(255,255,255,.07)!important;
      color:#fff !important;
      outline:0;
    }
    /* สีกะพริบ/แคร์เร็ตให้มองเห็น */
    input, textarea, select { caret-color:#ffbaf0; }

    /* dropdown list (บางเบราว์เซอร์ใช้เมนูของระบบปฏิบัติการ อาจไม่ครบทุกข้อ) */
    .form-select option{ background:#1c102e; color:#fff; }
    .form-select option:disabled{ color:#a28fc6; }
    /* ป้องกัน Chrome autofill เหลือง ๆ */
    input:-webkit-autofill,
    input:-webkit-autofill:hover,
    input:-webkit-autofill:focus{
      -webkit-text-fill-color:#fff;
      -webkit-box-shadow:0 0 0px 1000px rgba(255,255,255,.05) inset;
      transition:background-color 9999s ease-in-out 0s;
    }

    /* LABELS / HELPER */
    .form-label{ color:#e6d9ff; font-weight:600; }
    .help-text{ color:#c7b2ea; font-size:.85rem; }

    /* CONTACT CHANNEL CARD */
    .contact-card{
      border:1px solid rgba(255,255,255,.14);
      border-radius:18px; padding:14px;
      background:linear-gradient(145deg, rgba(255,255,255,.05), rgba(255,255,255,.02));
      transition:.2s; height:100%;
    }
    .contact-card:hover{ transform:translateY(-4px); border-color:rgba(229,0,255,.45); }

    /* FAQ */
    .accordion-button{
      background:rgba(255,255,255,.03); color:#fff;
      border:1px solid rgba(255,255,255,.18); border-radius:12px!important;
    }
    .accordion-item{background:transparent; border:0;}
    .accordion-body{ color:#e9dcff; }

    /* ระยะห่างเล็กๆ ให้ปุ่มล่างไม่ชนขอบ */
    .sticky-actions-fix{ padding-bottom:1rem; }
  </style>
</head>
<body>

<!-- NAVBAR (เหมือนหน้า Home) -->
<nav class="navbar navbar-expand-lg neon-nav" id="mainNav">
  <div class="container">
    <a class="navbar-brand brand-badge" href="${cp}/home">
      <span class="brand-logo"><i class="fa-solid fa-gem"></i></span>TermGems+
    </a>
    <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu" aria-controls="navMenu" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ms-4">
        <li class="nav-item"><a class="nav-link" href="${cp}/home">หน้าหลัก</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/games?mode=uid">เกมทั้งหมด</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/orders">ประวัติการเติม</a></li>
        <li class="nav-item"><a class="nav-link active" href="${cp}/support">ติดต่อเรา</a></li>
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


<!-- HEADER -->
<header class="page-hero">
  <div class="container">
    <h1 class="title-gradient"><i class="fa-solid fa-headset me-2" style="color:#ff6bd8;"></i>ฝ่ายบริการลูกค้า (Support)</h1>
    <div class="text-soft mt-1">ต้องการความช่วยเหลือ? ส่งคำถามถึงเรา หรือเลือกช่องทางติดต่อที่สะดวกได้เลย</div>
  </div>
</header>

<!-- FLASH -->
<c:if test="${not empty success}">
  <div class="container"><div class="alert alert-success border-0" role="alert">
    <i class="fa-solid fa-circle-check me-1"></i> ${success}
  </div></div>
</c:if>
<c:if test="${not empty error}">
  <div class="container"><div class="alert alert-danger border-0" role="alert">
    <i class="fa-solid fa-triangle-exclamation me-1"></i> ${error}
  </div></div>
</c:if>

<!-- CONTENT -->
<section class="pb-5 sticky-actions-fix">
  <div class="container">
    <div class="row g-4">

      <!-- LEFT: Contact form -->
      <div class="col-lg-7">
        <div class="panel">
          <div class="panel-header">
            <span class="dot"></span>
            <div class="fw-bold text-soft">ส่งคำถาม / เปิด Ticket</div>
          </div>

          <form action="${cp}/support/submit" method="post" novalidate>
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">ชื่อผู้ติดต่อ</label>
                <input type="text" name="name" class="form-control" required
                       value="<c:out value='${not empty user ? user.fullName : ""}'/>"
                       placeholder="เช่น สมชาย ใจดี">
              </div>
              <div class="col-md-6">
                <label class="form-label">อีเมล</label>
                <input type="email" name="email" class="form-control" required
                       value="<c:out value='${not empty user ? user.email : ""}'/>"
                       placeholder="your@email.com">
              </div>

              <div class="col-md-6">
                <label class="form-label">หัวข้อ</label>
                <input type="text" name="subject" class="form-control" required placeholder="สรุปปัญหา/คำถามสั้นๆ">
              </div>
              <div class="col-md-6">
                <label class="form-label">หมวดหมู่</label>
                <select class="form-select" name="category" required>
                  <option value="" selected disabled>— เลือก —</option>
                  <option>ปัญหาการเติม</option>
                  <option>การชำระเงิน/สลิป</option>
                  <option>บัญชีผู้ใช้</option>
                  <option>ข้อเสนอแนะ/ฟีเจอร์</option>
                  <option>อื่นๆ</option>
                </select>
              </div>

              <div class="col-md-6">
                <label class="form-label">เลขที่คำสั่งซื้อ (ถ้ามี)</label>
                <input type="text" name="orderId" class="form-control" placeholder="เช่น ORD-20251019-0001">
                <div class="help-text mt-1"><i class="fa-regular fa-circle-question me-1"></i>ช่วยให้ตรวจสอบได้เร็วขึ้น</div>
              </div>

              <div class="col-12">
                <label class="form-label">รายละเอียด</label>
                <textarea name="message" rows="6" class="form-control" required placeholder="อธิบายปัญหา/คำถามอย่างละเอียด..."></textarea>
              </div>

              <div class="col-12 d-flex align-items-center justify-content-between">
                <div class="help-text">
                  <i class="fa-solid fa-shield-halved me-1"></i>ข้อมูลของคุณปลอดภัยและใช้เพื่อช่วยเหลือคุณเท่านั้น
                </div>
                <button type="submit" class="btn btn-neon">
                  <i class="fa-solid fa-paper-plane me-1"></i> ส่งข้อมูล
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>

      <!-- RIGHT: Channels + Hours -->
      <div class="col-lg-5">
        <div class="panel mb-4">
          <div class="panel-header">
            <span class="dot"></span>
            <div class="fw-bold text-soft">ช่องทางติดต่อด่วน</div>
          </div>

          <div class="row g-3">
            <div class="col-sm-6">
              <a class="contact-card d-block text-decoration-none text-white" href="mailto:support@termgems.plus">
                <div class="d-flex align-items-center gap-3">
                  <div class="fs-3"><i class="fa-solid fa-envelope-open-text"></i></div>
                  <div>
                    <div class="fw-bold">อีเมล</div>
                    <div class="small text-soft">support@termgems.plus</div>
                  </div>
                </div>
              </a>
            </div>
            <div class="col-sm-6">
              <div class="contact-card">
                <div class="d-flex align-items-center gap-3">
                  <div class="fs-3"><i class="fa-brands fa-discord"></i></div>
                  <div>
                    <div class="fw-bold">Discord</div>
                    <div class="small text-soft">Community (เร็วๆนี้)</div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="contact-card">
                <div class="d-flex align-items-center gap-3">
                  <div class="fs-3"><i class="fa-solid fa-comments"></i></div>
                  <div>
                    <div class="fw-bold">Live Chat</div>
                    <div class="small text-soft">09:00–21:00 น. (ทดลอง)</div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-sm-6">
              <a class="contact-card d-block text-decoration-none text-white" href="${cp}/support#faq">
                <div class="d-flex align-items-center gap-3">
                  <div class="fs-3"><i class="fa-solid fa-book"></i></div>
                  <div>
                    <div class="fw-bold">ศูนย์ช่วยเหลือ</div>
                    <div class="small text-soft">อ่านคู่มือ/คำถามพบบ่อย</div>
                  </div>
                </div>
              </a>
            </div>
          </div>

          <hr class="border-0" style="height:1px;background:rgba(255,255,255,.12); margin:16px 0;">

          <div class="d-flex align-items-center justify-content-between flex-wrap gap-2">
            <div class="badge rounded-pill text-bg-dark border" style="border-color:rgba(255,255,255,.18)!important;">
              <i class="fa-regular fa-clock me-1"></i> เวลาทำการ: 24/7
            </div>
            <div class="badge rounded-pill text-bg-dark border" style="border-color:rgba(255,255,255,.18)!important;">
              <i class="fa-solid fa-language me-1"></i> ไทย / English
            </div>
          </div>
        </div>
      </div>

      <!-- FAQ -->
      <div class="col-12" id="faq">
        <div class="panel">
          <div class="panel-header">
            <span class="dot"></span>
            <div class="fw-bold text-soft">คำถามที่พบบ่อย (FAQ)</div>
          </div>
          <div class="accordion" id="faqAcc">
            <div class="accordion-item mb-2">
              <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#fq1">
                  เติมเงินแล้วสถานะ “รอตรวจสอบ” นานเท่าไหร่?
                </button>
              </h2>
              <div id="fq1" class="accordion-collapse collapse" data-bs-parent="#faqAcc">
                <div class="accordion-body">โดยทั่วไป 1–5 นาที หากเกิน 15 นาทีให้แนบเลขที่คำสั่งซื้อและสลิปผ่านฟอร์มด้านบน</div>
              </div>
            </div>

            <div class="accordion-item mb-2">
              <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#fq2">
                  สลิปผิด/ยอดไม่เข้า ต้องทำอย่างไร?
                </button>
              </h2>
              <div id="fq2" class="accordion-collapse collapse" data-bs-parent="#faqAcc">
                <div class="accordion-body">กรอกฟอร์ม “การชำระเงิน/สลิป” พร้อมแนบเลขที่คำสั่งซื้อ ทีมงานจะตรวจสอบและอัปเดตสถานะให้</div>
              </div>
            </div>

            <div class="accordion-item mb-2">
              <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#fq3">
                  ขอคืนเงินได้หรือไม่?
                </button>
              </h2>
              <div id="fq3" class="accordion-collapse collapse" data-bs-parent="#faqAcc">
                <div class="accordion-body">กรณีระบบตัดเงินแล้วไม่ได้รับสินค้า/เครดิต จะคืนเงินเต็มจำนวนภายใน 1–3 วันทำการ</div>
              </div>
            </div>

            <div class="accordion-item">
              <h2 class="accordion-header">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#fq4">
                  ต้องการใบเสร็จ/ใบกำกับภาษี
                </button>
              </h2>
              <div id="fq4" class="accordion-collapse collapse" data-bs-parent="#faqAcc">
                <div class="accordion-body">แจ้งข้อมูลนิติบุคคลในฟอร์มและเลือกหมวด “อื่นๆ” ระบุคำว่า ใบกำกับภาษี ทีมบัญชีจะส่งให้ทางอีเมล</div>
              </div>
            </div>

          </div>
        </div>
      </div>

    </div>
  </div>
</section>

<footer class="py-4 text-center">
  <div class="container small">© 2025 TermGems+. All rights reserved.</div>
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
