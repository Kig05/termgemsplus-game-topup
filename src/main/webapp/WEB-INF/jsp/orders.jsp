<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TermGems+ — รายการสั่งซื้อของฉัน</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

<style>
:root {
	--bg-1: #0b0614;
	--bg-2: #150a22;
	--text: #e7e3ee;
	--muted: #b9a9c9;
	--border: rgba(255, 255, 255, .08);
	--pink: #ff2bb3;
	--pink-2: #ff6bd8;
	--nav-bg: rgba(12, 6, 18, .75);
	--nav-bg-scrolled: rgba(12, 6, 18, .92);
	--purple-1: #b100ff;
	--purple-2: #8a2be2;
	--card-grad-1: #1a1025;
	--card-grad-2: #120b1a;
	--yellow: #ffd54a;
	--yellow-2: #ffc107;
	--gray-btn: #2d2731;
	--gray-border: rgba(255, 255, 255, .15);
}

body {
	color: var(--text);
	background: radial-gradient(1200px 600px at -10% -20%, #3b0c59 0%, transparent 60%),
		radial-gradient(900px 500px at 110% -10%, #27104d 0%, transparent 55%),
		radial-gradient(1200px 700px at 90% 120%, #140a2d 0%, transparent 65%),
		linear-gradient(180deg, var(--bg-2), var(--bg-1));
	min-height: 100vh;
}

/* NAVBAR: เหมือนหน้า Home */
.navbar.neon-nav {
	position: sticky;
	top: 0;
	z-index: 1030;
	background: var(--nav-bg);
	backdrop-filter: blur(10px);
	border-bottom: 1px solid var(--border);
	transition: background .25s ease, box-shadow .25s ease, padding .25s
		ease;
}

.navbar.neon-nav.stuck {
	background: var(--nav-bg-scrolled);
	box-shadow: 0 10px 30px rgba(0, 0, 0, .35);
	padding-top: .35rem;
	padding-bottom: .35rem;
}

.brand-badge {
	display: flex;
	align-items: center;
	gap: .6rem;
	color: #fff;
	font-weight: 800;
}

.brand-logo {
	width: 34px;
	height: 34px;
	border-radius: 10px;
	display: grid;
	place-items: center;
	color: #fff;
	background: radial-gradient(120% 120% at 30% 30%, #ff5bd1 0%, #7c3aed 55%, #2a0a43
		100%);
}

.navbar .nav-link {
	color: #b9a9c9;
	font-weight: 700;
	position: relative;
	padding: .9rem .9rem;
}

.navbar .nav-link:hover, .navbar .nav-link.active {
	color: #fff;
}

.navbar .nav-link::after {
	content: "";
	position: absolute;
	left: 14px;
	right: 14px;
	bottom: .35rem;
	height: 2px;
	background: linear-gradient(90deg, var(--pink), var(--pink-2));
	transform: scaleX(0);
	transform-origin: left;
	transition: transform .2s ease;
	box-shadow: 0 0 8px rgba(255, 43, 179, .6);
}

.navbar .nav-link:hover::after, .navbar .nav-link.active::after {
	transform: scaleX(1);
}

.search-wrap {
	background: rgba(255, 255, 255, .06);
	border: 1px solid var(--border);
	border-radius: 12px;
	padding: .35rem .7rem;
	display: flex;
	align-items: center;
	gap: .5rem;
	min-width: 280px;
}

.search-wrap input {
	background: transparent;
	border: 0;
	outline: none;
	color: var(--text);
	width: 100%;
}

.search-wrap input::placeholder {
	color: #9b8fb1;
}

.btn-neon {
	color: #fff;
	font-weight: 800;
	border-radius: 12px;
	padding: .5rem .9rem;
	border: 2px solid var(--pink);
	box-shadow: 0 0 0 3px rgba(255, 43, 179, .15), 0 0 18px
		rgba(255, 43, 179, .35) inset;
	background: linear-gradient(180deg, rgba(255, 255, 255, .02),
		rgba(255, 255, 255, .04));
	transition: .3s;
}

.btn-neon:hover {
	color: #160422;
	background: linear-gradient(90deg, var(--pink), var(--pink-2));
	box-shadow: 0 10px 26px rgba(255, 43, 179, .35);
}

/* PAGE HEADER */
.page-head {
	padding: 2.2rem 0 1.2rem;
	border-bottom: 1px solid var(--border);
}

.page-title {
	font-weight: 900;
	display: flex;
	align-items: center;
	gap: .7rem;
}

.page-title .icon {
	width: 40px;
	height: 40px;
	border-radius: 12px;
	display: grid;
	place-items: center;
	background: radial-gradient(120% 120% at 30% 30%, #ff5bd1 0%, #7c3aed 55%, #2a0a43
		100%);
	box-shadow: 0 8px 24px rgba(124, 58, 237, .35);
}

.page-sub {
	color: #cbbadf
}

/* FILTER CHIPS */
.filters {
	display: flex;
	flex-wrap: wrap;
	gap: .5rem;
	margin-top: 1rem;
}

.chip {
	border: 1px solid rgba(255, 255, 255, .16);
	color: #e9d7ff;
	border-radius: 999px;
	padding: .45rem .9rem;
	font-weight: 800;
	background: rgba(255, 255, 255, .04);
	transition: .2s;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: .45rem;
}

.chip:hover {
	border-color: rgba(255, 43, 179, .6);
	box-shadow: 0 0 14px rgba(255, 43, 179, .25);
}

.chip.active {
	background: linear-gradient(90deg, var(--pink), var(--pink-2));
	color: #160422;
	border-color: transparent;
}

/* ORDER CARD — แบบโชว์อย่างเดียว */
.card-neon {
	position: relative;
	border-radius: 22px;
	padding: 18px 16px;
	background: linear-gradient(180deg, var(--card-grad-1),
		var(--card-grad-2));
	border: 2px solid rgba(177, 0, 255, .55); /* เส้นม่วงชัด */
	box-shadow: 0 0 0 2px rgba(177, 0, 255, .25) inset,
		/* ขอบเรืองแสงด้านใน */
        0 10px 30px rgba(0, 0, 0, .45); /* เงาด้านล่าง */
	cursor: default; /* ไม่สื่อว่ากดได้ */
	transition: border-color .2s ease, box-shadow .2s ease;
}

.card-neon:hover {
	transform: none; /* ไม่ลอย */
	border-color: rgba(177, 0, 255, .75);
	box-shadow: 0 0 0 2px rgba(177, 0, 255, .35) inset, 0 0 25px
		rgba(138, 43, 226, .20);
}

.order-head {
	display: flex;
	align-items: center;
	gap: .8rem;
	justify-content: space-between;
	flex-wrap: wrap;
}

.order-left {
	display: flex;
	align-items: center;
	gap: .8rem;
	min-width: 260px;
}

.order-icon {
	width: 54px;
	height: 54px;
	border-radius: 16px;
	display: grid;
	place-items: center;
	flex-shrink: 0;
	background: radial-gradient(120% 120% at 30% 30%, #ff5bd1 0%, #7c3aed 55%, #2a0a43
		100%);
	box-shadow: 0 10px 26px rgba(124, 58, 237, .35);
	font-size: 1.2rem;
}

.order-title {
	font-weight: 900;
}

.order-sub {
	color: #cbbadf;
	font-size: .9rem;
}

.order-amount {
	font-weight: 900;
	font-size: 1.35rem;
}

.meta {
	color: #cbbadf;
	font-size: .9rem;
}

/* STATUS (เหลือง) */
.status-pill {
	display: inline-flex;
	align-items: center;
	gap: .5rem;
	border-radius: 999px;
	padding: .6rem 1.1rem;
	font-weight: 900;
	background: linear-gradient(90deg, var(--yellow), var(--yellow-2));
	color: #1b1422;
	border: 0;
	box-shadow: 0 6px 18px rgba(255, 193, 7, .25);
}

.status-pill i {
	font-size: 1rem;
}

/* ปุ่มยกเลิกสีเทา */
.btn-cancel {
	display: inline-flex;
	align-items: center;
	gap: .5rem;
	padding: .6rem 1.1rem;
	font-weight: 800;
	border-radius: 14px;
	background: var(--gray-btn);
	color: #e7dff1;
	border: 1px solid var(--gray-border);
	transition: .15s;
}

.btn-cancel:hover {
	filter: brightness(1.08);
}

/* Empty state */
.empty {
	text-align: center;
	padding: 3rem 1rem;
	border: 2px dashed rgba(255, 255, 255, .18);
	border-radius: 20px;
	background: rgba(255, 255, 255, .03);
}

.empty .icon {
	width: 64px;
	height: 64px;
	border-radius: 16px;
	display: grid;
	place-items: center;
	margin: 0 auto 1rem;
	background: radial-gradient(120% 120% at 30% 30%, #ff5bd1 0%, #7c3aed 55%, #2a0a43
		100%);
	box-shadow: 0 10px 26px rgba(124, 58, 237, .35);
}

footer {
	border-top: 1px solid var(--border);
}
</style>
</head>
<body>

	<!-- NAVBAR -->
	<nav class="navbar navbar-expand-lg neon-nav" id="mainNav">
		<div class="container">
			<a class="navbar-brand brand-badge" href="${cp}/home"> <span
				class="brand-logo"><i class="fa-solid fa-gem"></i></span>TermGems+
			</a>
			<button class="navbar-toggler text-white" type="button"
				data-bs-toggle="collapse" data-bs-target="#navMenu"
				aria-controls="navMenu" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navMenu">
				<ul class="navbar-nav ms-4">
					<li class="nav-item"><a class="nav-link" href="${cp}/home">หน้าหลัก</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${cp}/games?mode=uid">เกมทั้งหมด</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="${cp}/orders">ประวัติการเติม</a></li>
					<li class="nav-item"><a class="nav-link" href="${cp}/support">ติดต่อเรา</a></li>
					<li class="nav-item"><a class="nav-link" href="${cp}/profile">โปรไฟล์</a></li>
				</ul>

				<div class="ms-auto d-none d-lg-flex align-items-center gap-3">
					<!-- เปลี่ยนเป็น 'ออกจากระบบ' เมื่อมี user -->
					<c:choose>
						<c:when test="${not empty user}">
							<!-- แบบลิงก์ GET ธรรมดา -->
							<a href="${cp}/logout" class="btn btn-neon"> <i
								class="fa-solid fa-right-from-bracket me-1"></i> ออกจากระบบ
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
							<a href="${cp}/login" class="btn btn-neon"> <i
								class="fa-solid fa-user me-1"></i> เข้าสู่ระบบ
							</a>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- Mobile: แสดงปุ่ม login/logout ใต้เมนู -->
				<div class="d-lg-none mt-3">
					<c:choose>
						<c:when test="${not empty user}">
							<a href="${cp}/logout" class="btn btn-neon w-100"> <i
								class="fa-solid fa-right-from-bracket me-1"></i> ออกจากระบบ
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
							<a href="${cp}/login" class="btn btn-neon w-100"> <i
								class="fa-solid fa-user me-1"></i> เข้าสู่ระบบ
							</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</nav>


	<!-- PAGE HEADER -->
	<header class="page-head">
		<div class="container">
			<div
				class="d-flex align-items-start justify-content-between flex-wrap gap-3">
				<div>
					<div class="page-title h3 mb-1">
						<span class="icon"><i class="fa-solid fa-cart-shopping"></i></span>
						ประวัติการเติมเงิน (My Orders)
					</div>
					<div class="page-sub">ติดตามสถานะคำสั่งซื้อ ดูรายละเอียด
						และจัดการคำสั่งซื้อของคุณ</div>
				</div>

				<!-- Filters -->
				<div class="filters">
					<a class="chip ${empty selectedStatus ? 'active' : ''}"
						href="${cp}/orders"><i class="fa-solid fa-list-ul"></i>
						ทั้งหมด</a> <a
						class="chip ${selectedStatus eq 'pending' ? 'active' : ''}"
						href="${cp}/orders?status=pending"><i
						class="fa-solid fa-clock"></i> รอดำเนินการ</a> <a
						class="chip ${selectedStatus eq 'processing' ? 'active' : ''}"
						href="${cp}/orders?status=processing"><i
						class="fa-solid fa-gear"></i> กำลังดำเนินการ</a> <a
						class="chip ${selectedStatus eq 'completed' ? 'active' : ''}"
						href="${cp}/orders?status=completed"><i
						class="fa-solid fa-check-circle"></i> เสร็จสมบูรณ์</a> <a
						class="chip ${selectedStatus eq 'cancelled' ? 'active' : ''}"
						href="${cp}/orders?status=cancelled"><i
						class="fa-solid fa-ban"></i> ยกเลิก</a>
				</div>
			</div>
		</div>
	</header>

	<main class="py-4">
		<div class="container">

			<!-- Alerts -->
			<c:if test="${not empty success}">
				<div class="alert alert-success border-0" role="alert">
					<i class="fa-regular fa-circle-check me-2"></i>${success}
				</div>
			</c:if>
			<c:if test="${not empty error}">
				<div class="alert alert-danger border-0" role="alert">
					<i class="fa-regular fa-circle-xmark me-2"></i>${error}
				</div>
			</c:if>

			<!-- Empty -->
			<c:if test="${empty orders}">
				<div class="empty my-4">
					<div class="icon">
						<i class="fa-solid fa-inbox"></i>
					</div>
					<h4 class="fw-bold mb-1">ยังไม่มีคำสั่งซื้อ</h4>
					<div class="mb-3" style="color: #cbbadf">เริ่มต้นเลือกเกมเพื่อทำการเติมเงินได้เลย</div>
					<a href="${cp}/games" class="btn btn-neon"><i
						class="fa-solid fa-gamepad me-1"></i> ไปที่หน้าเกม</a>
				</div>
			</c:if>

			<!-- Orders list (SHOW ONLY) -->
			<div class="vstack gap-3">
				<c:forEach items="${orders}" var="order">
					<div class="card-neon">
						<!-- header row -->
						<div class="order-head">
							<div class="order-left">
								<div class="order-icon">
									<i class="fa-solid fa-gamepad"></i>
								</div>
								<div>
									<div class="order-title">${order.game != null ? order.game.name : 'Unknown Game'}</div>
									<div class="order-sub">
										<span class="me-2"><i
											class="fa-regular fa-hashtag me-1"></i>คำสั่งซื้อ
											#${order.id}</span> • <span class="ms-2"><i
											class="fa-regular fa-calendar me-1"></i>${order.createdAt}</span>
									</div>
								</div>
							</div>

							<div class="text-end">
								<div class="order-amount">
									฿
									<fmt:formatNumber value="${order.amount}" pattern="#,##0.00" />
								</div>
								<div class="meta">
									แพ็กเกจ: <strong>${order.packageName}</strong>
									<c:if test="${not empty order.gameServerName}">
                  • เซิร์ฟเวอร์: <strong>${order.gameServerName}</strong>
									</c:if>
								</div>
							</div>
						</div>

						<!-- body row -->
						<div class="row g-3 mt-3 align-items-center">
							<div class="col-lg-6">
								<!-- เลขคำสั่งซื้อ: วางไว้ "เหนือ" Game ID/UID -->
								<div class="meta mb-1">
									<i class="fa-solid fa-receipt me-1"></i> เลขคำสั่งซื้อ: <strong>
										ORD-${fn:replace(fn:substring(order.createdAt,0,10), "-", "")}-
										<fmt:formatNumber value="${order.id}" pattern="0000" />
									</strong>
								</div>

								<div class="meta">
									<i class="fa-regular fa-id-card me-1"></i> Game ID/UID: <strong>${order.gameUserId}</strong>
								</div>
							</div>

							<div class="col-lg-3">
								<c:choose>
									<c:when test="${order.status eq 'pending'}">
										<span class="status-pill"><i
											class="fa-regular fa-clock"></i> รอดำเนินการ</span>
									</c:when>
									<c:when test="${order.status eq 'processing'}">
										<span class="status-pill"
											style="background: linear-gradient(90deg, #67e8f9, #22d3ee); color: #0d0b12;">
											<i class="fa-solid fa-rotate"></i> กำลังดำเนินการ
										</span>
									</c:when>
									<c:when test="${order.status eq 'completed'}">
										<span class="status-pill"
											style="background: linear-gradient(90deg, #34d399, #22c55e); color: #0d0b12;">
											<i class="fa-solid fa-check"></i> เสร็จสมบูรณ์
										</span>
									</c:when>
									<c:otherwise>
										<span class="status-pill"
											style="background: linear-gradient(90deg, #f87171, #ef4444); color: #fff;">
											<i class="fa-solid fa-ban"></i> ยกเลิก
										</span>
									</c:otherwise>
								</c:choose>
							</div>

							<div class="col-lg-3 text-lg-end">
								<c:if test="${order.status eq 'pending'}">
									<form action="${cp}/orders/cancel/${order.id}" method="post"
										onsubmit="return confirm('ยืนยันยกเลิกคำสั่งซื้อนี้หรือไม่?');"
										class="d-inline">
										<button type="submit" class="btn-cancel">
											<i class="fa-solid fa-xmark"></i> ยกเลิก
										</button>
									</form>
								</c:if>
								<c:if test="${order.status eq 'completed'}">
									<span class="meta"><i
										class="fa-regular fa-calendar-check me-1"></i>${order.completedAt}</span>
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

		</div>
	</main>

	<footer class="py-4 mt-5 text-center">
		<div class="container small">© 2025 TermGems+. All rights
			reserved.</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
  (function(){
    const nav=document.getElementById('mainNav');
    const onScroll=()=>{window.scrollY>12?nav.classList.add('stuck'):nav.classList.remove('stuck');};
    onScroll();window.addEventListener('scroll',onScroll,{passive:true});
  })();
</script>
</body>
</html>
