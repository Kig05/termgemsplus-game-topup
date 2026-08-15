<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>สมัครสมาชิก — TermGems+</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    :root{
      --bg-1:#0b0614; --bg-2:#150a22; --text:#e7e3ee; --muted:#b9a9c9;
      --border:rgba(255,255,255,.10);
      --pink:#ff2bb3; --pink-2:#ff6bd8;
      --nav-bg: rgba(12, 6, 18, .75); --nav-bg-scrolled: rgba(12, 6, 18, .92);
      --ok:#20c997; --warn:#ffd166; --bad:#ff6b6b;
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
    .navbar.neon-nav{
      position:sticky; top:0; z-index:1030;
      background:var(--nav-bg); backdrop-filter:blur(10px);
      border-bottom:1px solid var(--border);
      transition:background .25s ease,box-shadow .25s ease,padding .25s ease;
    }
    .navbar.neon-nav.stuck{ background:var(--nav-bg-scrolled); box-shadow:0 10px 30px rgba(0,0,0,.35); padding-top:.35rem; padding-bottom:.35rem; }
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
    .btn-neon:hover{
      color:#160422; background:linear-gradient(90deg,var(--pink),var(--pink-2));
      box-shadow:0 10px 26px rgba(255,43,179,.35);
    }

    /* REGISTER WRAP */
    .wrap{ flex:1; display:grid; place-items:center; padding:2rem 1rem; }
    .auth-card{
      width:100%; max-width:720px;
      border-radius:26px;
      border:1px solid rgba(255,255,255,.14);
      background:linear-gradient(160deg, rgba(255,255,255,.06), rgba(255,255,255,.03));
      box-shadow:0 24px 60px rgba(0,0,0,.55);
      overflow:hidden;
    }
    .auth-head{
      padding:1.6rem 1.6rem 0; display:flex; align-items:center; gap:.8rem;
    }
    .auth-head .logo{
      width:46px; height:46px; border-radius:12px; display:grid; place-items:center;
      background:radial-gradient(120% 120% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%);
      color:#fff; font-size:1.1rem;
      box-shadow:0 10px 26px rgba(255,43,179,.35);
    }
    .auth-title{ font-weight:900; font-size:1.35rem; }
    .auth-sub{ color:#d9c8ef; }

    .form-area{ padding:1.4rem; }
    @media (min-width:992px){ .form-area{ padding:1.6rem 1.8rem 1.8rem; } }

    .panel{
      padding:1rem; border-radius:18px;
      border:1px solid rgba(255,255,255,.12);
      background:linear-gradient(160deg, rgba(255,255,255,.05), rgba(255,255,255,.02));
    }

    .form-label{ font-weight:700; color:#eedeff; }
    .form-control, .form-select{
      background:rgba(18,10,28,.65); color:#fff; border:1px solid rgba(255,255,255,.18);
      border-radius:12px; padding:.75rem .9rem;
    }
    .form-control::placeholder{ color:#bfb3d4; }
    .form-control:focus{ background:rgba(18,10,28,.9); color:#fff; border-color:#ff6bd8; box-shadow:0 0 0 .25rem rgba(255,43,179,.18); }

    .hint{ color:#cdbce3; font-size:.85rem; }

    .btn-primary{
      border:0; border-radius:14px; font-weight:900; padding:.9rem 1rem;
      background:linear-gradient(90deg,var(--pink),var(--pink-2));
      color:#160422; box-shadow:0 0 22px rgba(255,43,179,.35);
    }
    .btn-primary:hover{ filter:brightness(1.03); transform:translateY(-1px); }

    .meta{ color:#d8c7ee; }
    .link{ color:#ffbaf0; font-weight:800; text-decoration:none; }
    .link:hover{ color:#fff; text-decoration:underline; }

    /* Password strength bar */
    .strength{ height:8px; background:rgba(255,255,255,.08); border-radius:999px; overflow:hidden; }
    .strength > span{ display:block; height:100%; width:0%; transition:width .25s ease; }
    .strength.bad > span{ background:var(--bad); }
    .strength.warn > span{ background:var(--warn); }
    .strength.ok > span{ background:var(--ok); }

    footer{ color:#cdbce3; }
  </style>
</head>
<body>
<!-- CONTENT -->
<main class="wrap">
  <div class="container">
    <div class="auth-card mx-auto">
      <div class="auth-head">
        <div class="logo"><i class="fa-solid fa-user-plus"></i></div>
        <div>
          <div class="auth-title">สร้างบัญชีผู้ใช้</div>
          <div class="auth-sub">เข้าร่วมชุมชนเกมเมอร์ของเรา</div>
        </div>
      </div>

      <div class="form-area">
        <!-- error message -->
        <c:if test="${not empty error}">
          <div class="alert alert-danger border-0" role="alert">
            <i class="fa-solid fa-circle-exclamation me-2"></i>${error}
          </div>
        </c:if>

        <form action="${cp}/register" method="post" id="registerForm" class="row g-3">
          <div class="col-md-6">
            <label class="form-label" for="username"><i class="fa-solid fa-user me-1"></i> ชื่อผู้ใช้ <span class="text-danger">*</span></label>
            <input class="form-control" id="username" name="username" required minlength="3" pattern="[a-zA-Z0-9_]+" placeholder="เช่น gamer_123">
            <div class="hint mt-1">อย่างน้อย 3 ตัวอักษร (a-z, 0-9, _)</div>
          </div>

          <div class="col-md-6">
            <label class="form-label" for="fullName"><i class="fa-solid fa-id-card me-1"></i> ชื่อ-นามสกุล <span class="text-danger">*</span></label>
            <input class="form-control" id="fullName" name="fullName" required placeholder="ชื่อ-นามสกุลจริง">
          </div>

          <div class="col-md-6">
            <label class="form-label" for="email"><i class="fa-solid fa-envelope me-1"></i> อีเมล <span class="text-danger">*</span></label>
            <input type="email" class="form-control" id="email" name="email" required placeholder="email@example.com">
          </div>

          <div class="col-md-6">
            <label class="form-label" for="phoneNumber"><i class="fa-solid fa-phone me-1"></i> เบอร์โทร</label>
            <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="เช่น 08xxxxxxxx">
          </div>

          <div class="col-md-6">
            <label class="form-label" for="password"><i class="fa-solid fa-lock me-1"></i> รหัสผ่าน <span class="text-danger">*</span></label>
            <input type="password" class="form-control" id="password" name="password" required minlength="6" placeholder="อย่างน้อย 6 ตัวอักษร">
            <div class="strength mt-2" id="strength"><span></span></div>
          </div>

          <div class="col-md-6">
            <label class="form-label" for="confirmPassword"><i class="fa-solid fa-lock me-1"></i> ยืนยันรหัสผ่าน <span class="text-danger">*</span></label>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required minlength="6" placeholder="พิมพ์รหัสผ่านอีกครั้ง">
          </div>

          <div class="col-12">
            <div class="panel d-flex align-items-center gap-2">
              <input class="form-check-input mt-0" type="checkbox" value="1" id="terms" required>
              <label for="terms" class="m-0">ฉันยอมรับ <a class="link" href="#">เงื่อนไขการใช้บริการ</a> และ <a class="link" href="#">นโยบายความเป็นส่วนตัว</a></label>
            </div>
          </div>

          <div class="col-12 d-grid">
            <button type="submit" class="btn btn-primary btn-lg">
              <i class="fa-solid fa-user-plus me-2"></i> สมัครสมาชิก
            </button>
          </div>

          <div class="col-12 text-center meta">
            มีบัญชีแล้ว? <a class="link" href="${cp}/login">เข้าสู่ระบบที่นี่</a>
          </div>
        </form>
      </div>
    </div>
  </div>
</main>

<footer class="py-4 text-center mt-4">
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

  // password match + strength
  const form = document.getElementById('registerForm');
  const pwd = document.getElementById('password');
  const cpw = document.getElementById('confirmPassword');
  const bar = document.getElementById('strength');
  const span = bar.querySelector('span');

  function score(p){
    let s = 0;
    if(!p) return 0;
    if(p.length >= 6) s++;
    if(p.length >= 10) s++;
    if(/[A-Z]/.test(p)) s++;
    if(/[0-9]/.test(p)) s++;
    if(/[^A-Za-z0-9]/.test(p)) s++;
    return Math.min(s,4);
  }
  function renderStrength(){
    const s = score(pwd.value);
    span.style.width = (s*25)+'%';
    bar.classList.remove('bad','warn','ok');
    if(s<=1) bar.classList.add('bad');
    else if(s<=3) bar.classList.add('warn');
    else bar.classList.add('ok');
  }
  pwd.addEventListener('input', renderStrength);
  renderStrength();

  // ตรวจสอบเบอร์โทร
  const phone = document.getElementById('phoneNumber');
  phone.addEventListener('input', function () {
    this.value = this.value.replace(/[^0-9]/g, '');
    if (this.value.length >= 2) {
      const prefix = this.value.substring(0, 2);
      if (!['06', '08', '09'].includes(prefix)) {
        alert('กรุณากรอกเบอร์โทรที่ขึ้นต้นด้วย 06, 08 หรือ 09 เท่านั้น');
        this.value = '';
      }
    }
    if (this.value.length > 10) {
      this.value = this.value.slice(0, 10);
    }
  });

  form.addEventListener('submit', function(e){
    if(pwd.value !== cpw.value){
      e.preventDefault();
      alert('รหัสผ่านไม่ตรงกัน');
      cpw.focus();
      return false;
    }
  });
</script>
</body>
</html>
