// OceanViewReservation - shared UI helpers (no frameworks)

function $(id){ return document.getElementById(id); }

function toast(title, msg, type="ok", ms=2600){
  let wrap = document.querySelector(".toast-wrap");
  if(!wrap){
    wrap = document.createElement("div");
    wrap.className = "toast-wrap";
    document.body.appendChild(wrap);
  }
  const t = document.createElement("div");
  t.className = `toast ${type}`;
  t.innerHTML = `<div class="title">${title}</div><div class="msg">${msg}</div>`;
  wrap.appendChild(t);
  setTimeout(()=>{ t.style.opacity="0"; t.style.transform="translateY(-4px)"; }, ms-300);
  setTimeout(()=>{ t.remove(); }, ms);
}

async function api(path, opts={}){
  const res = await fetch(path, opts);
  const ct = res.headers.get("content-type") || "";
  const text = await res.text();
  let data = text;
  if(ct.includes("application/json")){
    try { data = JSON.parse(text); } catch { data = text; }
  }
  if(res.status === 401){
    // session expired or not logged in
    if(!location.href.endsWith("login.html")){
      location.href = "login.html";
    }
    throw new Error("Unauthorized");
  }
  if(!res.ok){
    const msg = (typeof data === "object" && data && data.error) ? data.error : text;
    throw new Error(msg || `Request failed: ${res.status}`);
  }
  return data;
}

async function requireAuth(){
  const me = await api("api/me");
  const badge = document.querySelector("[data-user-badge]");
  if(badge){
    badge.textContent = `${me.username} • ${me.role}`;
  }
  return me;
}

function money(v){
  const n = Number(v);
  if(Number.isNaN(n)) return v;
  return n.toFixed(2);
}