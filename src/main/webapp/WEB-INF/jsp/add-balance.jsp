<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>เติมยอดเงิน — TermGems+</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    :root{
      --bg-1:#0b0614; --bg-2:#150a22; --text:#e7e3ee; --muted:#b9a9c9;
      --border:rgba(255,255,255,.10);
      --pink:#ff2bb3; --pink-2:#ff6bd8;
      --ok:#20c997; --warn:#ffd166; --bad:#ff6b6b;
      --nav-bg: rgba(12, 6, 18, .75); --nav-bg-scrolled: rgba(12, 6, 18, .92);
      /* Readability */
      --text-strong:#ffffff;        /* สีตัวอักษรหลัก */
      --muted-strong:#d8c7ee;       /* สีข้อความรอง/คำอธิบาย */
      --muted-medium:#cdbce3;       /* สีรายละเอียดเล็ก */
    }

    body{
      color:var(--text);
      background:
        radial-gradient(1200px 600px at -10% -20%, #3b0c59 0%, transparent 60%),
        radial-gradient(900px 500px at 110% -10%, #27104d 0%, transparent 55%),
        radial-gradient(1200px 700px at 90% 120%, #140a2d 0%, transparent 65%),
        linear-gradient(180deg, var(--bg-2), var(--bg-1));
      min-height:100vh; display:flex; flex-direction:column;
    }

    /* NAVBAR */
    .navbar.neon-nav{
      position:sticky; top:0; z-index:1030;
      background:var(--nav-bg); backdrop-filter:blur(10px);
      border-bottom:1px solid var(--border);
      transition:background .25s ease,box-shadow .25s ease,padding .25s ease;
    }
    .navbar.neon-nav.stuck{ background:var(--nav-bg-scrolled); box-shadow:0 10px 30px rgba(0,0,0,.35);}
    .brand-badge{display:flex; align-items:center; gap:.6rem; color:#fff; font-weight:800;}
    .brand-logo{ width:34px; height:34px; border-radius:10px; display:grid; place-items:center; color:#fff;
      background:radial-gradient(120% 120% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%); }
    .navbar .nav-link{ color:#b9a9c9; font-weight:700; position:relative; padding:.9rem .9rem; }
    .navbar .nav-link:hover,.navbar .nav-link.active{ color:#fff; }
    .navbar .nav-link::after{
      content:""; position:absolute; left:14px; right:14px; bottom:.35rem; height:2px;
      background:linear-gradient(90deg,var(--pink),var(--pink-2));
      transform:scaleX(0); transform-origin:left; transition:transform .2s ease;
      box-shadow:0 0 8px rgba(255,43,179,.6);
    }
    .navbar .nav-link:hover::after,.navbar .nav-link.active::after{ transform:scaleX(1); }
    .btn-neon{
      color:#fff; font-weight:800; border-radius:12px; padding:.55rem .95rem;
      border:2px solid var(--pink);
      box-shadow:0 0 0 3px rgba(255,43,179,.15),0 0 18px rgba(255,43,179,.35) inset;
      background:linear-gradient(180deg,rgba(255,255,255,.02),rgba(255,255,255,.04));
      transition:.25s;
    }
    .btn-neon:hover{ color:#160422; background:linear-gradient(90deg,var(--pink),var(--pink-2)); box-shadow:0 10px 26px rgba(255,43,179,.35); }

    /* HEADER */
    .page-head{ padding:2rem 0 1.2rem; border-bottom:1px solid var(--border); }

    /* CARDS */
    .glass{
      border:1px solid rgba(255,255,255,.14);
      background:linear-gradient(160deg, rgba(255,255,255,.06), rgba(255,255,255,.03));
      border-radius:22px; box-shadow:0 24px 60px rgba(0,0,0,.5);
    }
    .glass-2{
      border:1px solid rgba(255,255,255,.12);
      background:linear-gradient(160deg, rgba(255,255,255,.05), rgba(255,255,255,.02));
      border-radius:18px;
    }

    /* ===== Readability Patch ===== */
    .text-muted, small, .form-text { color: var(--muted-strong) !important; opacity: 1 !important; }
    .amount-option, .payment-method, .glass, .glass-2 { color: var(--text); }
    .amount-option h4, .payment-method .fw-bold, h4, h5, h6, .form-label { color: var(--text-strong); }
    .amount-option small, .payment-method small { color: var(--muted-medium) !important; }
    .form-control::placeholder, .input-group-text { color: var(--muted-strong) !important; }
    .form-control{ color: var(--text-strong); }
    .form-control:focus{ color: var(--text-strong); }
    .alert{ color: var(--text-strong); background: rgba(255,255,255,.06); border-color: rgba(255,255,255,.16); }
    #summaryAmount, #summaryTotal { color:#ffd8f7; }

    /* OPTIONS */
    .amount-option{
      padding:1.1rem; text-align:center; border-radius:14px; cursor:pointer;
      border:2px solid rgba(255,255,255,.14);
      background:linear-gradient(180deg, rgba(255,255,255,.04), rgba(255,255,255,.02));
      transition:.22s; user-select:none;
    }
    .amount-option:hover{ transform:translateY(-4px); border-color:rgba(229,0,255,.45); box-shadow:0 10px 24px rgba(124,58,237,.25); }
    .amount-option.selected{ border-color:rgba(229,0,255,.8); box-shadow:0 0 0 3px rgba(255,43,179,.18), 0 16px 36px rgba(124,58,237,.35); }

    .payment-method{
      padding:1.1rem; text-align:center; border-radius:16px; cursor:pointer; position:relative;
      border:2px solid rgba(255,255,255,.14);
      background:linear-gradient(180deg, rgba(255,255,255,.04), rgba(255,255,255,.02));
      transition:.22s;
    }
    .payment-method:hover{ transform:translateY(-4px); border-color:rgba(229,0,255,.45); box-shadow:0 10px 24px rgba(124,58,237,.25); }
    .payment-method.selected{ border-color:rgba(229,0,255,.8); box-shadow:0 0 0 3px rgba(255,43,179,.18), 0 16px 36px rgba(124,58,237,.35); }
    .payment-method.selected::after{
      content:'\f00c'; font-family:'Font Awesome 6 Free'; font-weight:900;
      position:absolute; top:10px; right:12px; width:28px; height:28px; border-radius:50%;
      display:grid; place-items:center; background:linear-gradient(90deg,var(--pink),var(--pink-2)); color:#160422;
      box-shadow:0 0 12px rgba(255,43,179,.35);
    }

    /* INPUTS */
    .form-label{ font-weight:700; color:#eedeff; }
    .form-control{
      background:rgba(18,10,28,.65); border:1px solid rgba(255,255,255,.18);
      border-radius:12px; padding:.75rem .9rem;
    }
    .form-control:focus{
      background:rgba(18,10,28,.9); border-color:#ff6bd8; box-shadow:0 0 0 .25rem rgba(255,43,179,.18);
    }

    /* BUTTONS */
    .btn-primary{
      border:0; border-radius:14px; font-weight:900; padding:.9rem 1rem;
      background:linear-gradient(90deg,var(--pink),var(--pink-2));
      color:#160422; box-shadow:0 0 22px rgba(255,43,179,.35);
    }
    .btn-primary:hover{ filter:brightness(1.03); transform:translateY(-1px); }
    .btn-outline-secondary{ border-radius:12px; }
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
        <li class="nav-item"><a class="nav-link" href="${cp}/games?mode=uid">เกมทั้งหมด</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/orders">ประวัติการเติม</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/support">ติดต่อเรา</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/profile">โปรไฟล์</a></li>
      </ul>
      <div class="ms-auto">
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
<section class="page-head">
  <div class="container d-flex align-items-center justify-content-between flex-wrap">
    <div class="d-flex align-items-center gap-3">
      <div class="brand-logo" style="width:42px;height:42px;"><i class="fa-solid fa-wallet"></i></div>
      <div>
        <h2 class="mb-0 fw-bold">เติมยอดเงิน</h2>
        <div class="text-muted">Top up your account balance</div>
      </div>
    </div>
    <div class="mt-3 mt-lg-0">
      <a href="${cp}/profile" class="btn btn-outline-secondary"><i class="fa-solid fa-arrow-left me-1"></i> กลับโปรไฟล์</a>
    </div>
  </div>
</section>

<!-- CONTENT -->
<main class="py-4">
  <div class="container">
    <!-- Alerts -->
    <c:if test="${not empty error}">
      <div class="alert alert-danger border-0 glass-2" role="alert">
        <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
      </div>
    </c:if>

    <div class="row g-4">
      <!-- LEFT: Balance & Info -->
      <div class="col-lg-4">
        <div class="glass p-3">
          <div class="small" style="color:#d9c8ef;"><i class="fa-solid fa-shield-halved me-1"></i>Secure Wallet</div>
          <div class="mt-2">
            <div class="form-label mb-1">ยอดคงเหลือของคุณ</div>
            <div style="font-weight:900;font-size:2.2rem;color:#fff;">
              ฿<fmt:formatNumber value="${empty user ? 0 : user.balance}" pattern="#,##0.00"/>
            </div>
            <div class="small text-muted mt-1"><i class="fa-regular fa-clock me-1"></i>อัปเดตเรียลไทม์</div>
          </div>
        </div>

        <div class="glass-2 mt-3 p-3">
          <div class="fw-bold mb-2"><i class="fa-solid fa-circle-info me-2"></i>ข้อมูล</div>
          <ul class="small m-0">
            <li>เติมแล้วอัปเดตทันที</li>
            <li>ธุรกรรมปลอดภัย</li>
            <li>ไม่มีค่าธรรมเนียมแฝง</li>
            <li>รองรับ 24/7</li>
          </ul>
        </div>
      </div>

      <!-- RIGHT: Form -->
      <div class="col-lg-8">
        <div class="glass p-4">
          <h5 class="fw-bold mb-3"><i class="fa-solid fa-money-bill-wave me-2"></i>เลือกจำนวนเงิน</h5>

          <form action="${cp}/add-balance" method="post" id="addBalanceForm">
            <input type="hidden" name="amount" id="selectedAmount" value="0">
            <input type="hidden" name="paymentMethod" id="selectedPaymentMethod" value="credit_card">

            <!-- Quick Amounts -->
            <div class="row g-3 mb-4">
              <div class="col-6 col-md-3"><div class="amount-option" onclick="selectAmount(50,this)"><h4 class="mb-1">฿50</h4><small>Quick</small></div></div>
              <div class="col-6 col-md-3"><div class="amount-option" onclick="selectAmount(100,this)"><h4 class="mb-1">฿100</h4><small>Popular</small></div></div>
              <div class="col-6 col-md-3"><div class="amount-option" onclick="selectAmount(500,this)"><h4 class="mb-1">฿500</h4><small>Best</small></div></div>
              <div class="col-6 col-md-3"><div class="amount-option" onclick="selectAmount(1000,this)"><h4 class="mb-1">฿1,000</h4><small>Premium</small></div></div>
            </div>

            <!-- Custom Amount -->
            <div class="mb-4">
              <label class="form-label fw-bold">หรือกรอกจำนวนเงินเอง</label>
              <div class="input-group input-group-lg">
                <span class="input-group-text glass-2" style="border:none;border-radius:12px 0 0 12px;">฿</span>
                <input type="number" class="form-control" id="customAmount" min="1" max="100000" step="0.01" placeholder="เช่น 150.00">
              </div>
              <small class="text-muted">ขั้นต่ำ: ฿1 • สูงสุด: ฿100,000</small>
            </div>

            <!-- Payment Methods -->
            <div class="mb-4">
              <label class="form-label fw-bold">ช่องทางชำระเงิน</label>
              <div class="row g-3">
                <div class="col-md-4">
                  <div class="payment-method selected" onclick="selectPaymentMethod('credit_card',this)">
                    <i class="fa-solid fa-credit-card fa-2x mb-2" style="color:#87b5ff;"></i>
                    <div class="fw-bold">บัตรเครดิต</div>
                    <small>Visa / Mastercard</small>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="payment-method" onclick="selectPaymentMethod('mobile_banking',this)">
                    <i class="fa-solid fa-mobile-screen-button fa-2x mb-2" style="color:#7dffb2;"></i>
                    <div class="fw-bold">โมบายแบงก์กิ้ง</div>
                    <small>PromptPay / QR</small>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="payment-method" onclick="selectPaymentMethod('bank_transfer',this)">
                    <i class="fa-solid fa-building-columns fa-2x mb-2" style="color:#a8e4ff;"></i>
                    <div class="fw-bold">โอนผ่านธนาคาร</div>
                    <small>ทุกธนาคาร</small>
                  </div>
                </div>
              </div>

              <div class="glass-2 mt-3 p-3" id="paymentInfo">
                <i class="fa-solid fa-info-circle me-2"></i>
                <strong>บัตรเครดิต:</strong> ตัดเงินและอัปเดตยอดทันที • ระบบชำระเงินปลอดภัย
              </div>
            </div>

            <!-- Summary -->
            <div class="glass-2 p-3 mb-4">
              <h6 class="fw-bold mb-3">สรุปยอด</h6>
              <div class="d-flex justify-content-between mb-2">
                <span>จำนวนเงิน</span><strong id="summaryAmount">฿0.00</strong>
              </div>
              <div class="d-flex justify-content-between mb-2">
                <span>ค่าธรรมเนียม</span><strong class="text-success">ฟรี</strong>
              </div>
              <hr class="border-light">
              <div class="d-flex justify-content-between align-items-center">
                <strong>รวมทั้งสิ้น</strong><strong class="h4" id="summaryTotal">฿0.00</strong>
              </div>
            </div>

            <div class="d-grid gap-2">
              <button type="submit" class="btn btn-primary btn-lg">
                <i class="fa-solid fa-check-circle me-2"></i>ยืนยันการชำระเงิน
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</main>

<footer class="text-center py-4 mt-4">
  <div class="container small">© 2025 TermGems+. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // sticky nav
  (function(){
    const nav=document.getElementById('mainNav');
    const onScroll=()=>{window.scrollY>12?nav.classList.add('stuck'):nav.classList.remove('stuck');};
    onScroll(); window.addEventListener('scroll',onScroll,{passive:true});
  })();

  let selectedAmountValue = 0;
  let selectedPaymentMethodValue = 'credit_card';

  // Quick amount
  function selectAmount(amount, el){
    selectedAmountValue = Number(amount)||0;
    document.querySelectorAll('.amount-option').forEach(x=>x.classList.remove('selected'));
    el.classList.add('selected');
    const input = document.getElementById('customAmount');
    if(input) input.value = '';
    updateSummary(selectedAmountValue);
  }

  // Custom amount
  document.getElementById('customAmount').addEventListener('input', function(){
    const amount = parseFloat(this.value)||0;
    selectedAmountValue = amount;
    document.querySelectorAll('.amount-option').forEach(x=>x.classList.remove('selected'));
    updateSummary(amount);
  });

  function updateSummary(amount){
    const v = Number(amount)||0;
    document.getElementById('selectedAmount').value = v.toFixed(2);
    document.getElementById('summaryAmount').textContent = '฿'+v.toFixed(2);
    document.getElementById('summaryTotal').textContent  = '฿'+v.toFixed(2);
  }

  // Payment method
  function selectPaymentMethod(method, el){
    selectedPaymentMethodValue = method;
    document.querySelectorAll('.payment-method').forEach(x=>x.classList.remove('selected'));
    el.classList.add('selected');
    document.getElementById('selectedPaymentMethod').value = method;
    updatePaymentInfo(method);
  }

  function updatePaymentInfo(method){
    const box = document.getElementById('paymentInfo');
    let html = '';
    if(method==='credit_card'){
      html = '<i class="fa-solid fa-info-circle me-2"></i><strong>บัตรเครดิต:</strong> ตัดเงินและอัปเดตยอดทันที • ระบบชำระเงินปลอดภัย';
    }else if(method==='mobile_banking'){
      html = '<i class="fa-solid fa-info-circle me-2"></i><strong>โมบายแบงก์กิ้ง:</strong> สแกน QR ผ่านแอปธนาคาร (รองรับ PromptPay) • ยอดเข้าทันที';
    }else{
      html = '<i class="fa-solid fa-info-circle me-2"></i><strong>โอนผ่านธนาคาร:</strong> โอนเข้าบัญชีบริษัท • ใช้เวลา 1–2 ชม. ในการตรวจสอบ';
    }
    box.innerHTML = html;
  }

  // Validate
  document.getElementById('addBalanceForm').addEventListener('submit', function(e){
    if(selectedAmountValue<=0){
      e.preventDefault(); alert('กรุณาเลือกหรือกรอกจำนวนเงินที่ต้องการเติม'); return false;
    }
    if(selectedAmountValue>100000){
      e.preventDefault(); alert('จำนวนเงินสูงสุดที่อนุญาตคือ ฿100,000'); return false;
    }
    const names={credit_card:'บัตรเครดิต', mobile_banking:'โมบายแบงก์กิ้ง', bank_transfer:'โอนผ่านธนาคาร'};
    if(!confirm(`ยืนยันการชำระเงิน ฿${selectedAmountValue.toFixed(2)} ผ่าน ${names[selectedPaymentMethodValue]} ?`)){
      e.preventDefault(); return false;
    }
  });
</script>
</body>
</html>
