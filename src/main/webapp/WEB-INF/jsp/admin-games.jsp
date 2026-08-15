<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="cp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Games - Admin</title>
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
    .page-header{padding:2rem 0 1.3rem;border-bottom:1px solid var(--border);margin-bottom:1rem;}
    .text-soft{color:#cbbadf;}
    .panel{background:linear-gradient(180deg, rgba(255,255,255,.06), rgba(255,255,255,.03));border:1px solid rgba(255,255,255,.14);border-radius:18px;box-shadow:0 16px 44px rgba(0,0,0,.45);}
    .form-control,.form-select,textarea{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.16);color:#fff;}
    .form-control::placeholder,textarea::placeholder{color:#a995c4;}
    .badge-cat{background:rgba(124,58,237,.25);border:1px solid rgba(124,58,237,.5);}

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

/* === Edit Game Modal Ultra Dark + Pink Glow === */

/* ฉากหลังมืดขึ้นสุด + เบลอน้อยลงให้คม */
.modal-backdrop.show {
  background: rgba(3, 0, 7, 0.88);
  backdrop-filter: blur(2px);
}

/* กล่องโมดัลเข้มขึ้น + ขอบเรืองชมพู */
.modal .modal-content {
  background: radial-gradient(120% 180% at 30% 10%, rgba(60, 10, 95, 0.55), rgba(10, 5, 20, 0.95));
  border: 2px solid rgba(255, 43, 179, 0.4);
  border-radius: 16px;
  box-shadow:
    0 0 30px rgba(255, 43, 179, 0.4),
    0 0 60px rgba(255, 43, 179, 0.2),
    0 0 100px rgba(255, 43, 179, 0.15),
    inset 0 0 20px rgba(255, 255, 255, 0.03);
  color: #fff;
  animation: glowPulse 2.8s ease-in-out infinite alternate;
}

/* เอฟเฟกต์เรืองแสงนุ่มๆ */
@keyframes glowPulse {
  from {
    box-shadow:
      0 0 30px rgba(255, 43, 179, 0.35),
      0 0 70px rgba(255, 43, 179, 0.25),
      inset 0 0 10px rgba(255, 255, 255, 0.03);
  }
  to {
    box-shadow:
      0 0 45px rgba(255, 43, 179, 0.6),
      0 0 100px rgba(255, 43, 179, 0.4),
      inset 0 0 20px rgba(255, 255, 255, 0.05);
  }
}

/* เส้นหัวท้าย */
.modal .modal-header,
.modal .modal-footer {
  border-color: rgba(255, 255, 255, 0.12);
}

/* ชื่อหัวข้อ */
.modal .modal-title {
  color: #fff;
  font-weight: 900;
  letter-spacing: 0.3px;
  text-shadow: 0 0 8px rgba(255, 43, 179, 0.4);
}

/* Label */
.modal .form-label {
  color: #f3eaff;
  font-weight: 600;
}

/* ช่องกรอกพื้นดำสุด + ขอบชมพูตอน focus */
.modal .form-control,
.modal .form-select,
.modal textarea {
  background: rgba(6, 3, 10, 0.95) !important;
  border: 1px solid rgba(255, 255, 255, 0.22) !important;
  color: #ffffff !important;
  font-weight: 500;
}

.modal .form-control::placeholder,
.modal textarea::placeholder {
  color: #c6b2e3;
  opacity: 0.85;
}

/* Focus glow */
.modal .form-control:focus,
.modal .form-select:focus,
.modal textarea:focus {
  border-color: #ff2bb3 !important;
  box-shadow: 0 0 0 0.25rem rgba(255, 43, 179, 0.35) !important;
  background: rgba(12, 6, 18, 1) !important;
  outline: none;
}

/* Multiple select */
.modal .form-select[multiple] option {
  background: #12081c;
  color: #f3e9ff;
}
.modal .form-select[multiple] option:checked {
  background: #5a2089 linear-gradient(#5a2089, #5a2089);
  color: #fff;
}

/* Scrollbar */
.modal .form-select[multiple]::-webkit-scrollbar {
  width: 10px;
}
.modal .form-select[multiple]::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.25);
  border-radius: 8px;
}

/* ปุ่ม Save (นีออนชมพู) */
.modal .btn-neon {
  border: 2px solid #ff2bb3;
  box-shadow: 0 0 18px rgba(255, 43, 179, 0.45),
              0 0 36px rgba(255, 43, 179, 0.35);
  background: linear-gradient(180deg, rgba(255, 43, 179, 0.1), rgba(255, 255, 255, 0.04));
  color: #fff;
  font-weight: 700;
}
.modal .btn-neon:hover {
  background: linear-gradient(90deg, #ff2bb3, #ff6bd8);
  color: #160422;
  box-shadow: 0 0 40px rgba(255, 43, 179, 0.55);
}

/* ปุ่ม Cancel */
.modal .btn-secondary {
  background: rgba(255, 255, 255, 0.12);
  border: 1px solid rgba(255, 255, 255, 0.25);
  color: #fff;
}
.modal .btn-secondary:hover {
  background: rgba(255, 255, 255, 0.25);
}

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
        <li class="nav-item"><a class="nav-link active" href="${cp}/admin/games"><i class="fa-solid fa-gamepad me-1"></i>Games</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/orders"><i class="fa-solid fa-cart-shopping me-1"></i>Orders</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/users"><i class="fa-solid fa-users me-1"></i>Users</a></li>
        <li class="nav-item"><a class="nav-link" href="${cp}/admin/admin-report"><i class="fa-solid fa-bug me-1"></i>Reports</a></li>
      </ul>
      <div class="ms-auto d-flex"><a href="${cp}/logout" class="btn btn-neon">Logout</a></div>
    </div>
  </div>
</nav>

<header class="page-header">
  <div class="container d-flex align-items-center justify-content-between flex-wrap">
    <div>
      <h1 class="m-0 fw-bold"><i class="fa-solid fa-gamepad me-2"></i>Manage Games</h1>
      <div class="text-soft">เพิ่ม/แก้ไข/จัดการรายการเกม</div>
    </div>
  </div>
</header>

<main class="container pb-5">
  <c:if test="${not empty success}">
    <div class="alert alert-success border-0" role="alert"><i class="fa-regular fa-circle-check me-2"></i>${success}</div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alert alert-danger border-0" role="alert"><i class="fa-solid fa-triangle-exclamation me-2"></i>${error}</div>
  </c:if>

  <!-- ADD GAME -->
  <div class="panel p-3 mb-4">
    <div class="d-flex align-items-center justify-content-between border-bottom pb-2 mb-3" style="border-color:var(--border)!important;">
      <h5 class="m-0 fw-bold"><i class="fa-solid fa-circle-plus me-2"></i>เพิ่มเกมใหม่</h5>
    </div>
    <form action="${cp}/admin/games/add" method="post" id="addGameForm">
      <div class="row">
        <div class="col-md-6 mb-3">
          <label class="form-label">Game Name <span class="text-danger">*</span></label>
          <input type="text" class="form-control" name="name" required>
        </div>
        <div class="col-md-6 mb-3">
          <label class="form-label">Categories <span class="text-danger">*</span></label>
          <select class="form-select" id="addCategories" multiple style="height: 120px;">
            <option>MOBA</option><option>FPS</option><option>Battle Royale</option>
            <option>RPG</option><option>Strategy</option><option>Sports</option>
            <option>Adventure</option><option>Sandbox</option><option>Action</option>
            <option>Multiplayer</option><option>Tactical</option><option>Open World</option>
            <option>Esports</option>
          </select>
          <input type="hidden" name="category" id="addCategoriesInput" required>
          <small class="text-soft">กด Ctrl/Cmd เพื่อเลือกหลายรายการ</small>
        </div>
      </div>
      <div class="mb-3">
        <label class="form-label">Description</label>
        <textarea class="form-control" name="description" rows="2" maxlength="1000" placeholder="คำอธิบาย (ไม่บังคับ)"></textarea>
      </div>
      <div class="row">
        <div class="col-md-6 mb-3">
          <label class="form-label">Image URL</label>
          <input type="text" class="form-control" name="imageUrl" placeholder="https://via.placeholder.com/300x200">
        </div>
        <div class="col-md-3 mb-3">
          <label class="form-label">Active</label>
          <select class="form-select" name="active"><option value="true" selected>Yes</option><option value="false">No</option></select>
        </div>
        <div class="col-md-3 mb-3">
          <label class="form-label">Popular</label>
          <select class="form-select" name="popular"><option value="false" selected>No</option><option value="true">Yes</option></select>
        </div>
      </div>
      <div class="d-grid"><button type="submit" class="btn btn-neon"><i class="fa-solid fa-circle-plus me-2"></i>Add Game</button></div>
    </form>
  </div>

  <!-- GAMES TABLE -->
  <div class="panel">
    <div class="p-3 border-bottom" style="border-color:var(--border)!important;">
      <h5 class="m-0 fw-bold"><i class="fa-solid fa-list me-2"></i>All Games (${games.size()})</h5>
    </div>
    <div class="table-responsive p-2">
      <table class="table table-dark-neon align-middle mb-0">
        <thead>
          <tr>
            <th>ID</th><th>Image</th><th>Name</th><th>Category</th><th>Orders</th><th>Status</th><th>Popular</th><th>Actions</th>
          </tr>
        </thead>
        <tbody>
        <c:forEach items="${games}" var="game">
          <tr>
            <td><strong>${game.id}</strong></td>
            <td><img src="${game.imageUrl}" alt="${game.name}" style="width:80px;height:60px;object-fit:cover;border-radius:8px;border:1px solid rgba(255,255,255,.1);"></td>
            <td><strong>${game.name}</strong><br><small class="text-soft">${game.description}</small></td>
            <td>
              <c:forEach items="${game.categoryList}" var="cat">
                <span class="badge badge-cat me-1 mb-1">${cat}</span>
              </c:forEach>
            </td>
            <td><i class="fa-solid fa-bag-shopping me-1"></i>${game.orderCount}</td>
            <td>
              <form action="${cp}/admin/games/toggle-active/${game.id}" method="post" class="d-inline">
                <button type="submit" class="btn btn-sm ${game.active ? 'btn-success' : 'btn-secondary'}">${game.active ? 'Active' : 'Inactive'}</button>
              </form>
            </td>
            <td>
              <form action="${cp}/admin/games/toggle-popular/${game.id}" method="post" class="d-inline">
                <button type="submit" class="btn btn-sm ${game.popular ? 'btn-warning' : 'btn-outline-warning'}"><i class="fa-solid fa-star me-1"></i>${game.popular ? 'Popular' : 'Normal'}</button>
              </form>
            </td>
            <td>
              <div class="btn-group" role="group">
                <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#editGameModal${game.id}"><i class="fa-solid fa-pen"></i></button>
                <a href="${cp}/admin/games/${game.id}/packages" class="btn btn-sm btn-info"><i class="fa-solid fa-box-open"></i></a>
                <form action="${cp}/admin/games/delete/${game.id}" method="post" class="d-inline" onsubmit="return confirm('⚠️ ลบเกมและแพ็กเกจทั้งหมดของเกมนี้?\\n${game.name}');">
                  <button type="submit" class="btn btn-sm btn-danger"><i class="fa-solid fa-trash"></i></button>
                </form>
              </div>

              <!-- EDIT MODAL -->
              <div class="modal fade" id="editGameModal${game.id}" tabindex="-1">
                <div class="modal-dialog modal-lg"><div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title">Edit Game: ${game.name}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                  </div>
                  <form action="${cp}/admin/games/edit/${game.id}" method="post">
                    <div class="modal-body">
                      <div class="row">
                        <div class="col-md-6 mb-3">
                          <label class="form-label">Game Name</label>
                          <input type="text" class="form-control" name="name" value="${game.name}" required>
                        </div>
                        <div class="col-md-6 mb-3">
                          <label class="form-label">Categories</label>
                          <select class="form-select" id="editCategories${game.id}" multiple required style="height: 120px;">
                            <option>MOBA</option><option>FPS</option><option>Battle Royale</option>
                            <option>RPG</option><option>Strategy</option><option>Sports</option>
                            <option>Adventure</option><option>Sandbox</option><option>Action</option>
                            <option>Multiplayer</option><option>Tactical</option><option>Open World</option>
                            <option>Esports</option>
                          </select>
                          <input type="hidden" name="categories" id="editCategoriesInput${game.id}" value="${game.categories}">
                          <small class="text-soft">กด Ctrl/Cmd เพื่อเลือกหลายรายการ</small>
                          <script>
                            document.addEventListener('DOMContentLoaded', function() {
                              const cats='${game.categories}'.split(',');
                              const sel=document.getElementById('editCategories${game.id}');
                              Array.from(sel.options).forEach(o=>{ if(cats.includes(o.value)) o.selected=true; });
                            });
                          </script>
                        </div>
                      </div>
                      <div class="mb-3"><label class="form-label">Description</label>
                        <textarea class="form-control" name="description" rows="2" maxlength="1000">${game.description}</textarea>
                      </div>
                      <div class="mb-3"><label class="form-label">Image URL</label>
                        <input type="text" class="form-control" name="imageUrl" value="${game.imageUrl}"></input>
                      </div>
                      <div class="row">
                        <div class="col-md-6 mb-3">
                          <label class="form-label">Active</label>
                          <select class="form-select" name="active">
                            <option value="true" ${game.active ? 'selected' : ''}>Yes</option>
                            <option value="false" ${!game.active ? 'selected' : ''}>No</option>
                          </select>
                        </div>
                        <div class="col-md-6 mb-3">
                          <label class="form-label">Popular</label>
                          <select class="form-select" name="popular">
                            <option value="true" ${game.popular ? 'selected' : ''}>Yes</option>
                            <option value="false" ${!game.popular ? 'selected' : ''}>No</option>
                          </select>
                        </div>
                      </div>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                      <button type="submit" class="btn btn-neon"><i class="fa-solid fa-floppy-disk me-1"></i>Save</button>
                    </div>
                  </form>
                </div></div>
              </div>
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
<script>
  // Multi-select -> hidden input (Add)
  document.querySelector('form[action*="/add"]').addEventListener('submit', function(){
    const select=document.getElementById('addCategories');
    const selected=Array.from(select.selectedOptions).map(o=>o.value);
    document.getElementById('addCategoriesInput').value=selected.join(',');
  });
  // Multi-select -> hidden input (Edit)
  document.querySelectorAll('form[action*="/edit/"]').forEach(form=>{
    form.addEventListener('submit', function(){
      const id=this.action.split('/').pop();
      const select=document.getElementById('editCategories'+id);
      const selected=Array.from(select.selectedOptions).map(o=>o.value);
      document.getElementById('editCategoriesInput'+id).value=selected.join(',');
    });
  });
</script>
</body>
</html>
