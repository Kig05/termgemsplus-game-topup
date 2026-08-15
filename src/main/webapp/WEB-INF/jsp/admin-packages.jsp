<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Packages - ${game.name}</title>
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
    .neon-nav{position:sticky;top:0;z-index:1030;background:rgba(12,6,18,.78);backdrop-filter:blur(10px);border-bottom:1px solid var(--border);}
    .brand-badge{display:flex;align-items:center;gap:.6rem;color:#fff;font-weight:800;}
    .brand-logo{width:34px;height:34px;border-radius:10px;display:grid;place-items:center;color:#fff;background:radial-gradient(120% 120% at 30% 30%,#ff5bd1 0%,#7c3aed 55%,#2a0a43 100%);}
    .navbar .nav-link{color:#b9a9c9;font-weight:700;position:relative;padding:.9rem .9rem;}
    .navbar .nav-link:hover,.navbar .nav-link.active{color:#fff;}
    .navbar .nav-link::after{content:"";position:absolute;left:14px;right:14px;bottom:.35rem;height:2px;background:linear-gradient(90deg,var(--pink),var(--pink-2));transform:scaleX(0);transform-origin:left;transition:transform .2s ease;}
    .navbar .nav-link:hover::after,.navbar .nav-link.active::after{transform:scaleX(1);}
    .btn-neon{color:#fff;font-weight:800;border-radius:12px;padding:.5rem .9rem;border:2px solid var(--pink);box-shadow:0 0 0 3px rgba(255,43,179,.15),0 0 18px rgba(255,43,179,.35) inset;background:linear-gradient(180deg,rgba(255,255,255,.02),rgba(255,255,255,.04));}
    .btn-neon:hover{color:#160422;background:linear-gradient(90deg,var(--pink),var(--pink-2));box-shadow:0 10px 26px rgba(255,43,179,.35);}
    .page-header{padding:1.2rem 0;border-bottom:1px solid var(--border);margin-bottom:1rem;}
    .text-soft{color:#cbbadf;}
    .panel{background:linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.03));border:1px solid rgba(255,255,255,.14);border-radius:18px;box-shadow:0 16px 44px rgba(0,0,0,.45);}
    .form-control{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.16);color:#fff;}

    /* ====== TABLE (Dark theme + white text) ====== */
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

    /* ====== Modal: Ultra Dark + Pink Glow (เหมือน Edit Game) ====== */
    .modal-backdrop.show{
      background: rgba(3,0,7,.88);
      backdrop-filter: blur(2px);
    }
    .modal .modal-content{
      background: radial-gradient(120% 180% at 30% 10%, rgba(60,10,95,.55), rgba(10,5,20,.95));
      border: 2px solid rgba(255,43,179,.4);
      border-radius: 16px;
      box-shadow:
        0 0 30px rgba(255,43,179,.4),
        0 0 60px rgba(255,43,179,.2),
        0 0 100px rgba(255,43,179,.15),
        inset 0 0 20px rgba(255,255,255,.03);
      color:#fff;
      animation: glowPulse 2.8s ease-in-out infinite alternate;
    }
    @keyframes glowPulse{
      from{ box-shadow:0 0 30px rgba(255,43,179,.35), 0 0 70px rgba(255,43,179,.25), inset 0 0 10px rgba(255,255,255,.03);}
      to  { box-shadow:0 0 45px rgba(255,43,179,.6), 0 0 100px rgba(255,43,179,.4), inset 0 0 20px rgba(255,255,255,.05);}
    }
    .modal .modal-header,.modal .modal-footer{ border-color: rgba(255,255,255,.12); }
    .modal .modal-title{ color:#fff;font-weight:900;letter-spacing:.3px;text-shadow:0 0 8px rgba(255,43,179,.4); }
    .modal .form-label{ color:#f3eaff;font-weight:600; }
    .modal .form-control,.modal .form-select,.modal textarea{
      background: rgba(6,3,10,.95) !important;
      border:1px solid rgba(255,255,255,.22) !important;
      color:#fff !important;
      font-weight:500;
    }
    .modal .form-control::placeholder,.modal textarea::placeholder{ color:#c6b2e3; opacity:.85; }
    .modal .form-control:focus,.modal .form-select:focus,.modal textarea:focus{
      border-color:#ff2bb3 !important; box-shadow:0 0 0 .25rem rgba(255,43,179,.35) !important; background:rgba(12,6,18,1) !important; outline:none;
    }
    .modal .btn-neon{
      border:2px solid #ff2bb3;
      box-shadow:0 0 18px rgba(255,43,179,.45),0 0 36px rgba(255,43,179,.35);
      background:linear-gradient(180deg, rgba(255,43,179,.1), rgba(255,255,255,.04));
      color:#fff;font-weight:700;
    }
    .modal .btn-neon:hover{ background:linear-gradient(90deg,#ff2bb3,#ff6bd8); color:#160422; box-shadow:0 0 40px rgba(255,43,179,.55); }
    .modal .btn-secondary{ background:rgba(255,255,255,.12); border:1px solid rgba(255,255,255,.25); color:#fff; }
    .modal .btn-secondary:hover{ background:rgba(255,255,255,.25); }

    /* preview image border */
    .img-preview{ border-radius:8px;border:1px solid rgba(255,255,255,.12);max-width:200px; }
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
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/orders"><i class="fa-solid fa-cart-shopping me-1"></i>Orders</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/users"><i class="fa-solid fa-users me-1"></i>Users</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/admin-report"><i class="fa-solid fa-bug me-1"></i>Reports</a></li>
      </ul>
      <div class="ms-auto d-flex"><a href="${cp}/logout" class="btn btn-neon">Logout</a></div>
    </div>
  </div>
</nav>

<header class="page-header">
  <div class="container">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a class="text-soft" href="${cp}/admin/games">Games</a></li>
        <li class="breadcrumb-item active text-white">${game.name} - Packages</li>
      </ol>
    </nav>
    <h1 class="m-0 fw-bold"><i class="fa-solid fa-box-open me-2"></i>Manage Packages</h1>
    <div class="text-soft">${game.name} - ${game.category}</div>
  </div>
</header>

<main class="container pb-5">
  <c:if test="${not empty success}">
    <div class="alert alert-success border-0" role="alert"><i class="fa-regular fa-circle-check me-2"></i>${success}</div>
  </c:if>
  <c:if test="${not empty error}"><div class="alert alert-danger border-0" role="alert"><i class="fa-solid fa-triangle-exclamation me-2"></i>${error}</div></c:if>

  <!-- ADD PACKAGE -->
  <div class="panel p-3 mb-4">
    <div class="d-flex align-items-center justify-content-between border-bottom pb-2 mb-3" style="border-color:var(--border)!important;">
      <h5 class="m-0 fw-bold"><i class="fa-solid fa-circle-plus me-2"></i>เพิ่มแพ็กเกจใหม่</h5>
    </div>
    <form action="${cp}/admin/games/${game.id}/packages/add" method="post">
      <div class="row">
        <div class="col-md-3 mb-3"><label class="form-label">Package Name*</label><input class="form-control" name="name" required placeholder="100 Diamonds"></div>
        <div class="col-md-3 mb-3"><label class="form-label">Price (฿)*</label><input class="form-control" name="price" type="number" step="0.01" min="1" required placeholder="35.00"></div>
        <div class="col-md-3 mb-3"><label class="form-label">Description</label><input class="form-control" name="description" placeholder="Optional"></div>
        <div class="col-md-3 mb-3"><label class="form-label">Image URL</label><input class="form-control" name="imageUrl" placeholder="https://..."></div>
      </div>
      <div class="d-grid"><button class="btn btn-neon" type="submit"><i class="fa-solid fa-circle-plus me-2"></i>Add Package</button></div>
    </form>
  </div>

  <!-- TABLE -->
  <div class="panel">
    <div class="p-3 border-bottom" style="border-color:var(--border)!important;">
      <h5 class="m-0 fw-bold"><i class="fa-solid fa-list me-2"></i>All Packages (${packages.size()})</h5>
    </div>
    <div class="table-responsive p-2">
      <table class="table table-dark-neon align-middle mb-0">
        <thead>
          <tr>
            <th>ID</th><th>Image</th><th>Package Name</th><th class="text-end">Price</th><th>Description</th><th>Orders</th><th>Status</th><th>Actions</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach items="${packages}" var="pkg">
          <tr>
            <td><strong>${pkg.id}</strong></td>
            <td>
              <c:choose>
                <c:when test="${not empty pkg.imageUrl}">
                  <img src="${pkg.imageUrl}" alt="${pkg.name}" style="width:60px;height:60px;object-fit:cover;border-radius:8px;border:1px solid rgba(255,255,255,.12);">
                </c:when>
                <c:otherwise>
                  <div style="width:60px;height:60px;background:rgba(255,255,255,.06);border-radius:8px;display:flex;align-items:center;justify-content:center;border:1px solid rgba(255,255,255,.12);">
                    <i class="fa-regular fa-image text-soft"></i>
                  </div>
                </c:otherwise>
              </c:choose>
            </td>
            <td><strong>${pkg.name}</strong></td>
            <td class="text-end">฿<fmt:formatNumber value="${pkg.price}" pattern="#,##0.00"/></td>
            <td>${pkg.description}</td>
            <td><i class="fa-solid fa-bag-shopping me-1"></i>${pkg.orderCount}</td>
            <td>
              <form action="${cp}/admin/packages/toggle-active/${pkg.id}" method="post" class="d-inline">
                <button class="btn btn-sm ${pkg.active ? 'btn-success' : 'btn-secondary'}" type="submit">${pkg.active ? 'Active' : 'Inactive'}</button>
              </form>
            </td>
            <td>
              <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editModal${pkg.id}"><i class="fa-solid fa-pen"></i></button>
              <form action="${cp}/admin/packages/delete/${pkg.id}" method="post" class="d-inline" onsubmit="return confirm('Delete this package?');">
                <button class="btn btn-sm btn-danger" type="submit"><i class="fa-solid fa-trash"></i></button>
              </form>

              <!-- EDIT MODAL -->
              <div class="modal fade" id="editModal${pkg.id}" tabindex="-1">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">Edit Package</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${cp}/admin/packages/edit/${pkg.id}" method="post">
                      <div class="modal-body">
                        <div class="mb-3"><label class="form-label">Package Name</label><input class="form-control" name="name" value="${pkg.name}" required></div>
                        <div class="mb-3"><label class="form-label">Price (฿)</label><input class="form-control" name="price" type="number" step="0.01" value="${pkg.price}" required></div>
                        <div class="mb-3"><label class="form-label">Description</label><input class="form-control" name="description" value="${pkg.description}"></div>
                        <div class="mb-3">
                          <label class="form-label">Image URL</label>
                          <input class="form-control" name="imageUrl" value="${pkg.imageUrl}" placeholder="https://...">
                          <c:if test="${not empty pkg.imageUrl}">
                            <div class="mt-2"><img src="${pkg.imageUrl}" alt="Preview" class="img-preview"></div>
                          </c:if>
                        </div>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-neon"><i class="fa-solid fa-floppy-disk me-1"></i>Save</button>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
              <!-- /EDIT MODAL -->
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

  <div class="mt-3"><a href="${cp}/admin/games" class="btn btn-outline-light"><i class="fa-solid fa-arrow-left me-2"></i>Back to Games</a></div>
</main>

<footer class="py-4 mt-5 text-center">
  <div class="container small text-soft">© 2025 TermGems+ Admin Panel. All rights reserved.</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
