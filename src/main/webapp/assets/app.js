

(function () {
  "use strict";

  const $ = (id) => document.getElementById(id);

  const page = (() => {
    const parts = (location.pathname || "").split("/");
    return (parts[parts.length - 1] || "").toLowerCase();
  })();

  function getHashId() {
    const m = (location.hash || "").match(/id=(\d+)/);
    return m ? m[1] : null;
  }

  function money(v) {
    const n = Number(v);
    return Number.isFinite(n) ? n.toFixed(2) : String(v);
  }

  function showToast(message) {
    const toast = $("toast");
    const toastMessage = $("toastMessage");
    if (!toast || !toastMessage) return;

    toastMessage.textContent = message;

    toast.classList.remove("hidden");
    requestAnimationFrame(() => {
      toast.classList.remove("translate-y-10", "opacity-0");
      toast.classList.add("translate-y-0", "opacity-100");
    });

    setTimeout(() => {
      toast.classList.add("translate-y-10", "opacity-0");
      toast.classList.remove("translate-y-0", "opacity-100");
      setTimeout(() => toast.classList.add("hidden"), 250);
    }, 2600);
  }

  async function api(path, opts = {}) {
    const res = await fetch(path, {
      credentials: "same-origin",
      ...opts,
      headers: {
        ...(opts.headers || {}),
      },
    });

    const ct = (res.headers.get("content-type") || "").toLowerCase();
    const text = await res.text();

    let data = text;
    if (ct.includes("application/json")) {
      try {
        data = JSON.parse(text);
      } catch {
        data = text;
      }
    }

    // Handle unauthorized globally
    if (res.status === 401) {
      if (page !== "login.html") location.href = "login.html";
      throw new Error(
        (data && typeof data === "object" && data.error) ||
          "Unauthorized. Please login."
      );
    }

    if (!res.ok) {
      const msg =
        (data && typeof data === "object" && (data.error || data.message)) ||
        (data && typeof data === "object" && data.create === "fail" && data.error) ||
        (data && typeof data === "object" && data.login === "fail" && data.error) ||
        (typeof data === "string" && data.trim()) ||
        `Request failed (${res.status})`;
      throw new Error(msg);
    }

    return data;
  }

  async function requireAuth() {
    const me = await api("api/me");

    // Update badge (dashboard uses [data-user-badge] with an inner span)
    const badge = document.querySelector("[data-user-badge]");
    if (badge) {
      const span = badge.querySelector("span");
      const label = `${me.username} (${me.role})`;
      if (span) span.textContent = label;
      else badge.textContent = label;
    }
    return me;
  }

  function setPrimaryButton(btn) {
    if (!btn) return;
    btn.classList.remove(
      "bg-slate-200",
      "dark:bg-slate-800",
      "text-slate-400",
      "dark:text-slate-500"
    );
    btn.classList.add(
      "bg-primary",
      "text-background-dark",
      "hover:opacity-90",
      "transition-opacity"
    );
  }

  // ---------------- Page init: Index ----------------
  async function initIndex() {
    try {
      await api("api/me");
      location.replace("dashboard.html");
    } catch {
      location.replace("login.html");
    }
  }

  // ---------------- Page init: Login ----------------
  function initLogin() {
    const form = $("loginForm");
    if (!form) return;

    form.addEventListener("submit", async (e) => {
      e.preventDefault();

      const out = $("out");
      if (out) {
        out.textContent = "";
        out.classList.add("hidden");
      }

      const username = ($("username")?.value || "").trim();
      const password = $("password")?.value || "";

      if (!username || !password) {
        const msg = "Enter username and password.";
        if (out) {
          out.textContent = msg;
          out.classList.remove("hidden");
        }
        showToast(msg);
        return;
      }

      try {
        await api("api/login", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ username, password }),
        });
        location.href = "dashboard.html";
      } catch (err) {
        const msg = err.message || "Login failed";
        if (out) {
          out.textContent = msg;
          out.classList.remove("hidden");
        }
        showToast(msg);
      }
    });
  }

  // ---------------- Page init: Dashboard ----------------
  async function initDashboard() {
    await requireAuth();

    const logoutForm = $("logoutForm");
    if (!logoutForm) return;

    logoutForm.addEventListener("submit", async (e) => {
      e.preventDefault();
      try {
        await api("api/logout", { method: "POST" });
        location.href = "login.html";
      } catch (err) {
        alert(err.message);
      }
    });
  }

  // ---------------- Page init: Add Reservation ----------------
  async function initAddReservation() {
    await requireAuth();

    const typeSel = $("typeId");
    if (typeSel) {
      typeSel.innerHTML =
        '<option disabled selected value="">Loading room types...</option>';
      try {
        const types = await api("api/room-types");
        typeSel.innerHTML = "";
        (types || []).forEach((t) => {
          const opt = document.createElement("option");
          opt.value = t.typeId;
          opt.textContent = `${t.typeName} (Rs. ${money(t.nightlyRate)}/night)`;
          typeSel.appendChild(opt);
        });
        if (!typeSel.children.length) {
          typeSel.innerHTML =
            '<option disabled selected value="">No room types found</option>';
        }
      } catch (err) {
        typeSel.innerHTML =
          '<option disabled selected value="">Failed to load room types</option>';
        alert("Failed to load room types: " + err.message);
      }
    }

    const form = $("reservationForm");
    if (!form) return;

    form.addEventListener("submit", async (e) => {
      e.preventDefault();

      const guestName = ($("guestName")?.value || "").trim();
      const contactNo = ($("contactNo")?.value || "").trim();
      const email = ($("email")?.value || "").trim();
      const address = ($("address")?.value || "").trim();
      const typeId = parseInt(($("typeId")?.value || "0"), 10);
      const checkIn = $("checkIn")?.value || "";
      const checkOut = $("checkOut")?.value || "";

      // Client validation (doesn't change backend rules)
      if (!guestName) return alert("Guest Name is required.");
      if (!contactNo) return alert("Contact Number is required.");
      if (!checkIn) return alert("Check-in date is required.");
      if (!checkOut) return alert("Check-out date is required.");
      if (checkOut <= checkIn) return alert("Check-out must be after Check-in.");
      if (!typeId) return alert("Room Type is required.");

      const digitsOnly = contactNo.replace(/\D/g, "");
      if (digitsOnly.length < 9) return alert("Contact number seems too short.");

      if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        return alert("Email format is invalid.");
      }

      try {
        const res = await api("api/reservations", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            guestName,
            contactNo,
            email,
            address,
            typeId,
            checkIn,
            checkOut,
          }),
        });

        const id = res.reservationId;
        if (!id) throw new Error("Reservation created, but ID missing.");

        // Show success panel
        const outPanel = $("out");
        if (outPanel) outPanel.classList.remove("hidden");

        // Pretty display like RES-00001
        const niceId = "RES-" + String(id).padStart(5, "0");
        const idEl = $("reservationIdDisplay");
        if (idEl) idEl.textContent = niceId;

        const link = $("viewReservationLink");
        if (link) link.href = `view-reservation.html#id=${encodeURIComponent(id)}`;
      } catch (err) {
        alert(err.message);
      }
    });

    // Clear hides the success panel
    const clearBtn = $("btnClear");
    if (clearBtn) {
      clearBtn.addEventListener("click", () => {
        const outPanel = $("out");
        if (outPanel) outPanel.classList.add("hidden");
      });
    }
  }

  // ---------------- Page init: View Reservation ----------------
  async function initViewReservation() {
    await requireAuth();

    const ridInput = $("rid");
    const btnSearch = $("btnSearch");
    const btnBill = $("btnBill");

    async function load(id) {
      try {
        const r = await api("api/reservations?id=" + encodeURIComponent(id));

        if ($("out")) $("out").textContent = JSON.stringify(r, null, 2);

        if ($("result")) $("result").classList.remove("hidden");

        if ($("res-guest-name")) $("res-guest-name").textContent = r.guestName || "---";
        if ($("res-guest-email"))
          $("res-guest-email").textContent = r.email || r.contactNo || "---";

        if ($("res-room-type")) {
          $("res-room-type").textContent = r.typeName
            ? `${r.typeName} (Rs. ${money(r.nightlyRate)}/night)`
            : "---";
        }
        if ($("res-room-id")) $("res-room-id").textContent = `Reservation #${r.reservationId}`;
        if ($("res-checkin")) $("res-checkin").textContent = r.checkIn || "---";
        if ($("res-checkout")) $("res-checkout").textContent = r.checkOut || "---";

        if (btnBill) {
          btnBill.disabled = false;
          setPrimaryButton(btnBill);
          btnBill.onclick = () =>
            (location.href = `bill.html#id=${encodeURIComponent(r.reservationId)}`);
        }
      } catch (err) {
        if ($("out")) $("out").textContent = err.message;
        if ($("result")) $("result").classList.add("hidden");
        if (btnBill) btnBill.disabled = true;
      }
    }

    if (btnSearch) {
      btnSearch.addEventListener("click", async () => {
        const id = (ridInput?.value || "").trim();
        if (!id) return alert("Enter a Reservation ID.");
        await load(id);
      });
    }

    const hid = getHashId();
    if (hid) {
      if (ridInput) ridInput.value = hid;
      await load(hid);
    }
  }

  // ---------------- Page init: Bill ----------------
  async function initBill() {
    await requireAuth();

    const ridInput = $("rid");
    const btnLoad = $("btnLoad");
    const btnPrint = $("btnPrint");

    function enablePrint() {
      if (!btnPrint) return;
      btnPrint.disabled = false;
      setPrimaryButton(btnPrint);
      // Print button text color should be dark on primary background
      btnPrint.classList.remove("text-background-dark");
      btnPrint.classList.add("text-slate-900");
    }

    async function loadBill(id) {
      try {
        const b = await api("api/bill?id=" + encodeURIComponent(id));

        // header labels
        if ($("invDate")) {
          const d = new Date();
          const pad = (n) => String(n).padStart(2, "0");
          $("invDate").textContent = `Date: ${pad(d.getDate())}/${pad(
            d.getMonth() + 1
          )}/${d.getFullYear()}`;
        }
        if ($("invId")) $("invId").textContent = "Invoice #: INV-" + b.reservationId;

        // rows
        const rows = $("invRows");
        if (rows) {
          const roomLine = `${b.roomType} (Rs. ${money(b.nightlyRate)}/night)`;
          rows.innerHTML = `
            <tr class="border-b border-slate-200 dark:border-slate-800">
              <td class="py-4">
                <div class="font-bold text-slate-900 dark:text-slate-100">${roomLine}</div>
                <div class="text-xs text-slate-500 dark:text-slate-400 mt-1">
                  Guest: ${b.guestName} • Contact: ${b.contactNo}<br/>
                  ${b.checkIn} → ${b.checkOut}
                </div>
              </td>
              <td class="py-4 text-center font-bold">${b.nights}</td>
              <td class="py-4 text-right font-bold">Rs. ${money(b.nightlyRate)}</td>
              <td class="py-4 text-right font-bold">Rs. ${money(b.total)}</td>
            </tr>
          `;
        }

        // UI-only tax = 0 (backend unchanged)
        const subtotal = Number(b.total) || 0;
        const tax = 0;
        const total = subtotal + tax;

        if ($("subtotal")) $("subtotal").textContent = "Rs. " + money(subtotal);
        if ($("tax")) $("tax").textContent = "Rs. " + money(tax);
        if ($("total")) $("total").textContent = "Rs. " + money(total);

        enablePrint();
      } catch (err) {
        const rows = $("invRows");
        if (rows) {
          rows.innerHTML = `<tr><td colspan="4" class="py-10 text-center text-red-500 font-medium">${err.message}</td></tr>`;
        }
        if ($("subtotal")) $("subtotal").textContent = "Rs. 0.00";
        if ($("tax")) $("tax").textContent = "Rs. 0.00";
        if ($("total")) $("total").textContent = "Rs. 0.00";
        if (btnPrint) btnPrint.disabled = true;
      }
    }

    if (btnLoad) {
      btnLoad.addEventListener("click", async () => {
        const id = (ridInput?.value || "").trim();
        if (!id) return alert("Enter a Reservation ID.");
        await loadBill(id);
      });
    }

    if (btnPrint) btnPrint.addEventListener("click", () => window.print());

    const hid = getHashId();
    if (hid) {
      if (ridInput) ridInput.value = hid;
      await loadBill(hid);
    }
  }

  // ---------------- Boot ----------------
  async function boot() {
    // index redirect
    if (page === "" || page === "index.html") return initIndex();

    // login page
    if ($("loginForm")) return initLogin();

    // dashboard
    if ($("logoutForm")) return initDashboard();

    // add reservation
    if ($("reservationForm")) return initAddReservation();

    // view reservation
    if ($("btnSearch") && $("rid") && $("out") && $("result")) return initViewReservation();

    // bill
    if ($("btnLoad") && $("invRows") && $("subtotal") && $("total")) return initBill();

    // help or other pages: no JS needed
  }

  // Run after DOM is ready
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", () => void boot());
  } else {
    void boot();
  }

  // expose for debugging (optional)
  window.api = api;
  window.requireAuth = requireAuth;
})();