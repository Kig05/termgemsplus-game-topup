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
<title>TermGems+ — เติมเกมออนไลน์</title>
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
}

body {
	color: var(--text);
	background: radial-gradient(1200px 600px at -10% -20%, #3b0c59 0%, transparent 60%),
		radial-gradient(900px 500px at 110% -10%, #27104d 0%, transparent 55%),
		radial-gradient(1200px 700px at 90% 120%, #140a2d 0%, transparent 65%),
		linear-gradient(180deg, var(--bg-2), var(--bg-1));
	min-height: 100vh;
}

/* NAVBAR */
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

/* HERO LAYOUT */
.hero {
	position: relative;
	z-index: 1;
	padding: 2.5rem 0 3rem;
}

.actions-panel {
	position: relative;
	padding: 18px;
	border-radius: 26px;
	background: linear-gradient(180deg, rgba(255, 255, 255, .05),
		rgba(255, 255, 255, .02));
	border: 1px solid rgba(255, 255, 255, .12);
	box-shadow: 0 18px 44px rgba(0, 0, 0, .45);
	height: 100%;
}

.panel-header {
	display: flex;
	align-items: center;
	gap: .6rem;
	margin-bottom: .8rem;
}

.panel-header .dot {
	width: 8px;
	height: 8px;
	border-radius: 999px;
	background: linear-gradient(90deg, #ff2bb3, #ff6bd8);
	box-shadow: 0 0 10px rgba(255, 43, 179, .8);
}

.text-soft {
	color: #cbbadf;
}

/* NEWS BOX */
.news-box {
	padding: 16px 18px;
	border-radius: 18px;
	border: 1px solid rgba(255, 255, 255, .15);
	background: linear-gradient(145deg, rgba(255, 255, 255, .05),
		rgba(255, 255, 255, .02));
	box-shadow: 0 8px 25px rgba(255, 43, 179, .25);
	color: #fff;
	font-weight: 600;
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: .6rem;
	animation: fadeIn .8s ease;
}

.news-box:hover {
	border-color: rgba(255, 43, 179, .5);
	box-shadow: 0 0 20px rgba(255, 43, 179, .4);
}

.news-text {
	flex: 1;
	min-width: 0;
}

.news-text strong {
	white-space: nowrap;
}

.news-text span {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.news-btn {
	font-weight: 700;
	color: #ffbaf0;
	text-decoration: none;
	border: 1px solid rgba(255, 43, 179, .4);
	border-radius: 10px;
	padding: 6px 12px;
	font-size: .85rem;
	transition: .2s;
	flex-shrink: 0;
}

.news-btn:hover {
	background: linear-gradient(90deg, #ff2bb3, #ff6bd8);
	color: #160422;
	box-shadow: 0 0 10px rgba(255, 43, 179, .4);
}

@
keyframes fadeIn {
	from {opacity: 0;
	transform: translateY(6px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* BREAKING TICKER (CSS only) */
.ticker {
	position: relative;
	overflow: hidden;
	border-radius: 12px;
	border: 1px solid rgba(255, 255, 255, .12);
	background: rgba(255, 255, 255, .03);
	margin-top: .9rem;
}

.ticker .track {
	display: inline-block;
	white-space: nowrap;
	padding: .6rem 1rem;
	animation: tickerScroll 22s linear infinite;
	font-weight: 700;
	color: #ffbaf0;
}

@
keyframes tickerScroll {from { transform:translateX(0%);
	
}

to {
	transform: translateX(-50%);
} /* track มีข้อความซ้ำ 2 รอบ */
}

/* PROMO BOX */
.promo-box {
	margin-top: .9rem;
	border: 1px solid rgba(255, 255, 255, .15);
	background: linear-gradient(145deg, rgba(255, 255, 255, .05),
		rgba(255, 255, 255, .02));
	border-radius: 18px;
	box-shadow: 0 8px 25px rgba(255, 43, 179, .25);
	padding: 1rem 1.1rem;
	text-align: center;
}

.promo-box .headline {
	font-weight: 800;
	margin-bottom: .25rem;
}

.promo-box .sub {
	color: #d9c8ef;
	margin-bottom: .6rem;
}

.promo-box .mini {
	display: inline-block;
	padding: .25rem .6rem;
	border-radius: 999px;
	border: 1px solid rgba(255, 255, 255, .18);
	font-size: .8rem;
	color: #ffd8f7;
}

/* GREETING + QUICK LINKS */
.greeting {
	margin-top: .9rem;
	display: flex;
	gap: .8rem;
	align-items: center;
	justify-content: space-between;
	flex-wrap: wrap;
	border: 1px dashed rgba(255, 255, 255, .15);
	border-radius: 12px;
	padding: .6rem .9rem;
	background: rgba(255, 255, 255, .03);
}

.quick-links .btn {
	padding: .4rem .7rem;
	border-radius: 10px;
}

/* BALANCE + GAME CARD (ของเดิม) */
.balance-card {
	background: linear-gradient(180deg, rgba(255, 255, 255, .08),
		rgba(255, 255, 255, .04));
	border: 1px solid rgba(255, 255, 255, .14);
	backdrop-filter: blur(12px);
	border-radius: 24px;
	box-shadow: 0 20px 46px rgba(0, 0, 0, .5);
	padding: 22px 18px;
	height: 100%;
}

.balance-chip {
	width: 42px;
	height: 30px;
	border-radius: 6px;
	background: linear-gradient(180deg, #E6C77E, #B8923A);
}

.balance-amount {
	font-weight: 900;
	font-size: 2.3rem;
	color: #fff;
}

.balance-label {
	color: #d5c8e6;
	opacity: .9;
	font-weight: 700;
}

.btn-topup-light {
	display: block;
	width: 100%;
	background: linear-gradient(90deg, #ff2bb3, #ff6bd8);
	border: 0;
	border-radius: 14px;
	padding: .85rem 1rem;
	font-weight: 900;
	color: #160422;
	box-shadow: 0 0 22px rgba(255, 43, 179, .35);
	transition: transform .15s ease, opacity .15s ease;
}

.btn-topup-light:hover {
	opacity: .95;
	transform: translateY(-2px);
}

.game-card {
	border-radius: 20px;
	background: linear-gradient(180deg, rgba(255, 255, 255, .06),
		rgba(255, 255, 255, .02));
	border: 2px solid rgba(229, 0, 255, .35);
	box-shadow: 0 8px 28px rgba(124, 58, 237, .20);
	padding: 14px;
	transition: .22s;
}

.game-card:hover {
	transform: translateY(-6px);
	border-color: rgba(229, 0, 255, .6);
}

.game-thumb {
	width: 100%;
	height: 170px;
	object-fit: cover;
	border-radius: 16px;
}

.game-title {
	text-align: center;
	font-weight: 800;
	margin: 18px 0 10px;
}

.btn-outline-neon {
	display: block;
	margin: 0 auto;
	width: 140px;
	border: 2px solid #ff2bb3;
	color: #e9d7ff;
	border-radius: 12px;
	padding: .55rem .9rem;
	font-weight: 800;
}

.btn-outline-neon:hover {
	color: #160422;
	background: linear-gradient(90deg, #ff2bb3, #ff6bd8);
	box-shadow: 0 10px 26px rgba(255, 43, 179, .35);
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
					<li class="nav-item"><a class="nav-link active"
						href="${cp}/home">หน้าหลัก</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${cp}/games?mode=uid">เกมทั้งหมด</a></li>
					<li class="nav-item"><a class="nav-link" href="${cp}/orders">ประวัติการเติม</a></li>
					<li class="nav-item"><a class="nav-link" href="${cp}/support">ติดต่อเรา</a></li>
					<li class="nav-item"><a class="nav-link" href="${cp}/profile">โปรไฟล์</a></li>
				</ul>

				<!-- Desktop: search + login/logout -->
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

	<!-- ===== HERO: NEWS + EXTRAS ===== -->
	<section class="hero">
		<div class="container">
			<div class="row g-4 align-items-stretch">

				<!-- ข่าวจำลอง -->
				<c:set var="newsMock"
					value="โปรแรง 10.10 มาแล้ว!||เติม Coin รับโบนัสสูงสุด 15% วันนี้วันเดียว,
                    อัปเดตเกม ROV||แพ็กเพชรใหม่ลดเพิ่ม 8% ถึง 31 ต.ค. เท่านั้น,
                    แจ้งปรับปรุงระบบ||หยุดให้บริการ 02:00–03:30 น. วันที่ 22 ต.ค.,
                    สมาชิกใหม่รับของขวัญ||สมัครวันนี้ รับคูปองส่วนลด 50 บาท,
                    โปรโมชั่นคืนเงิน||สะสมยอดเติมครบ 1,000 บาท รับเงินคืน 3% อัตโนมัติ" />

				<!-- ข้อความ ticker จำลอง -->
				<c:set var="tickerMock"
					value="🎯 โปรโมชันเดือนนี้: เติม ROV รับโบนัสเพิ่ม 8% • 🎮 เปิดขาย Gift Card Steam แล้ววันนี้ • 💎 ระบบดี เติมง่าย เติมไว ปลอดภัย 100% • 📣 ติดตามประกาศที่หน้าเพจ Facebook TermGems+ " />

				<!-- LEFT: ข่าว + ส่วนเสริมครบองค์ประกอบ -->
				<div class="col-lg-8">
					<div class="actions-panel">
						<div class="panel-header">
							<span class="dot"></span>
							<div class="fw-bold text-soft">ข่าวสาร & ประชาสัมพันธ์</div>
						</div>

						<!-- ข่าวเลื่อนอัตโนมัติ -->
						<div id="newsCarousel" class="carousel slide"
							data-bs-ride="carousel" data-bs-interval="3800"
							data-bs-pause="false">
							<div class="carousel-inner">
								<c:forTokens items="${newsMock}" delims="," var="item"
									varStatus="st">
									<c:set var="pair" value="${fn:split(item,'||')}" />
									<div class="carousel-item ${st.first ? 'active' : ''}">
										<div class="news-box">
											<div class="news-text">
												<i class="fa-solid fa-newspaper me-2"
													style="color: #ff6bd8;"></i> <strong>${fn:trim(pair[0])}</strong>
												— <span class="text-soft">${fn:trim(pair[1])}</span>
											</div>
										</div>
									</div>
								</c:forTokens>
							</div>
						</div>

						<!-- Breaking Ticker -->
						<div class="ticker">
							<div class="track">${tickerMock}${tickerMock}</div>
						</div>

						<!-- Promo Box -->
						<div class="promo-box">
							<div class="headline">
								<i class="fa-solid fa-gift me-2" style="color: #ff6bd8;"></i>กิจกรรมพิเศษประจำสัปดาห์
							</div>
							<div class="sub">
								เติม Coin ครบ <b>฿300</b> รับโบนัสเพิ่ม <b>฿30</b> อัตโนมัติ •
								ถึงวันอาทิตย์นี้เท่านั้น
							</div>
							<span class="mini"><i class="fa-solid fa-clock me-1"></i>หมดเขต
								23:59 น.</span>
						</div>

					</div>
				</div>

				<!-- RIGHT: Balance -->
				<div class="col-lg-4">
					<div class="balance-card">
						<div class="d-flex align-items-center justify-content-between">
							<div class="balance-chip"></div>
							<div class="small text-soft fw-bold">
								<i class="fa-solid fa-shield-halved me-1"></i>Secure Wallet
							</div>
						</div>
						<div class="mt-3">
							<div class="balance-label mb-1">ยอดคงเหลือของคุณ</div>
							<div class="balance-amount mb-2">
								<c:choose>
									<c:when test="${not empty user}">
     								฿<fmt:formatNumber value="${user.balance}" pattern="#,##0.00" />
									</c:when>
									<c:otherwise>
										<span class="text-soft">กรุณาเข้าสู่ระบบ</span>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="text-soft small mb-3">
								<i class="fa-regular fa-user me-1"></i>
								<c:choose>
									<c:when test="${not empty user and not empty user.fullName}">${user.fullName}</c:when>
									<c:otherwise>ผู้ใช้งาน</c:otherwise>
								</c:choose>
							</div>
							<a href="${cp}/add-balance" class="btn-topup-light"> <i
								class="fa-solid fa-plus me-2"></i> เติมยอดเงิน
							</a>
						</div>
						<div
							class="d-flex align-items-center justify-content-between mt-3">
							<div class="small text-soft">
								<i class="fa-regular fa-clock me-1"></i>อัปเดตล่าสุดไม่กี่วินาที
							</div>
							<div class="small text-soft">
								<i class="fa-solid fa-lock me-1"></i>256-bit
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</section>

	<!-- POPULAR GAMES -->
	<section class="py-2">
		<div class="container">
			<div class="d-flex align-items-center justify-content-between mb-4">
				<h3 class="mb-0">
					<i class="fa-solid fa-fire me-2 text-danger"></i>เกมยอดนิยม
				</h3>
				<a href="${cp}/games" class="btn btn-neon px-3 py-2"> <i
					class="fa-solid fa-arrow-right me-1"></i> ดูทั้งหมด
				</a>
			</div>

			<div class="row g-4">
				<c:forEach items="${popularGames}" var="game" varStatus="st">
					<c:if test="${st.index < 8}">
						<div class="col-6 col-md-4 col-lg-3">
							<div class="game-card position-relative">
								<img class="game-thumb" src="${game.imageUrl}"
									alt="${game.name}">
								<div class="game-title">${game.name}</div>
								<span class="btn btn-outline-neon">เติมเกม</span> <a
									href="${cp}/topup/${game.id}" class="stretched-link"
									aria-label="เติม ${game.name}"></a>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</section>

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
