/* OceanViewReservation - frontend wiring only
   Backend endpoints remain unchanged:
   GET  api/me
   POST api/login
   POST api/logout
   GET  api/room-types
   POST api/reservations
   GET  api/reservations?id=...
   GET  api/bill?id=...
*/

(function () {
  "use strict";

  const $ = (id) => document.getElementById(id);
  const page = (() => {
    const parts = (window.location.pathname || "").split("/");
    return (parts[parts.length - 1] || "index.html").toLowerCase();
  })();

  const PUBLIC_PAGES = new Set(["index.html", "login.html", "help.html", ""]);

  function isProtectedPage() {
    return !PUBLIC_PAGES.has(page);
  }

  function getHashId() {
    const match = (window.location.hash || "").match(/(?:^|#)id=(\d+)/i);
    return match ? match[1] : null;
  }

  function money(value) {
    const amount = Number(value);
    return Number.isFinite(amount) ? amount.toFixed(2) : "0.00";
  }

  function reservationCode(id) {
    const numeric = Number(id);
    return Number.isFinite(numeric) ? `RES-${String(numeric).padStart(5, "0")}` : "RES-00000";
  }

  function nightsBetween(checkIn, checkOut) {
    const start = new Date(checkIn);
    const end = new Date(checkOut);
    const ms = end - start;
    return Number.isFinite(ms) && ms > 0 ? Math.round(ms / 86400000) : 0;
  }

  function escapeHtml(value) {
    return String(value ?? "")
      .replaceAll("&", "&amp;")
      .replaceAll("<", "&lt;")
      .replaceAll(">", "&gt;")
      .replaceAll('"', "&quot;")
      .replaceAll("'", "&#39;");
  }

  function showPanel(id, message) {
    const el = $(id);
    if (!el) return;
    el.textContent = message;
    el.classList.remove("hidden");
  }

  function hidePanel(id) {
    const el = $(id);
    if (!el) return;
    el.textContent = "";
    el.classList.add("hidden");
  }

  function setText(id, value, fallback = "--") {
    const el = $(id);
    if (!el) return;
    const text = value == null || value === "" ? fallback : value;
    el.textContent = text;
  }

  function setHtml(id, value) {
    const el = $(id);
    if (!el) return;
    el.innerHTML = value;
  }

  function setBusy(button, busy, busyLabel = "Loading...") {
    if (!button) return;

    if (busy) {
      if (!button.dataset.originalHtml) {
        button.dataset.originalHtml = button.innerHTML;
      }
      button.disabled = true;
      button.classList.add("opacity-70");
      button.innerHTML = `<span class="material-symbols-outlined animate-spin">progress_activity</span><span>${escapeHtml(busyLabel)}</span>`;
      return;
    }

    button.disabled = false;
    button.classList.remove("opacity-70");
    if (button.dataset.originalHtml) {
      button.innerHTML = button.dataset.originalHtml;
    }
  }

  function bindEnter(input, callback) {
    if (!input) return;
    input.addEventListener("keydown", (event) => {
      if (event.key === "Enter") {
        event.preventDefault();
        callback();
      }
    });
  }

  function digitsOnlyInput(id) {
    const input = $(id);
    if (!input) return;

    input.addEventListener("input", () => {
      const cleaned = input.value.replace(/[^\d+ ]/g, "");
      if (cleaned !== input.value) {
        input.value = cleaned;
      }
    });
  }

  function setupDateConstraints() {
    const checkIn = $("checkIn");
    const checkOut = $("checkOut");
    if (!checkIn || !checkOut) return;

    const today = new Date();
    const pad = (n) => String(n).padStart(2, "0");
    const todayValue = `${today.getFullYear()}-${pad(today.getMonth() + 1)}-${pad(today.getDate())}`;
    checkIn.min = todayValue;

    const updateCheckOutMin = () => {
      if (!checkIn.value) return;
      const minDate = new Date(checkIn.value);
      minDate.setDate(minDate.getDate() + 1);
      const minOut = `${minDate.getFullYear()}-${pad(minDate.getMonth() + 1)}-${pad(minDate.getDate())}`;
      checkOut.min = minOut;
      if (checkOut.value && checkOut.value < minOut) {
        checkOut.value = "";
      }
    };

    checkIn.addEventListener("change", updateCheckOutMin);
    updateCheckOutMin();
  }

  function ensureToast() {
    if ($("ovrToast")) return;

    const toast = document.createElement("div");
    toast.id = "ovrToast";
    toast.className = "fixed bottom-6 right-6 z-[9999] hidden translate-y-6 opacity-0 transition-all duration-300";
    toast.innerHTML = `
      <div class="flex items-center gap-3 rounded-xl border border-slate-800 bg-slate-950/80 px-5 py-3 text-sm font-medium text-slate-100 shadow-xl backdrop-blur">
        <span class="material-symbols-outlined text-xl" id="ovrToastIcon">info</span>
        <span id="ovrToastMsg">Message</span>
      </div>
    `;
    document.body.appendChild(toast);
  }

  function toast(message, type = "info") {
    ensureToast();
    const wrap = $("ovrToast");
    const icon = $("ovrToastIcon");
    const text = $("ovrToastMsg");
    if (!wrap || !icon || !text) return;

    text.textContent = message;
    icon.textContent = type === "ok" ? "check_circle" : type === "err" ? "error" : type === "warn" ? "warning" : "info";

    wrap.classList.remove("hidden");
    requestAnimationFrame(() => {
      wrap.classList.remove("translate-y-6", "opacity-0");
      wrap.classList.add("translate-y-0", "opacity-100");
    });

    window.clearTimeout(window.__ovrToastTimer);
    window.__ovrToastTimer = window.setTimeout(() => {
      wrap.classList.add("translate-y-6", "opacity-0");
      wrap.classList.remove("translate-y-0", "opacity-100");
      window.setTimeout(() => wrap.classList.add("hidden"), 250);
    }, 2600);
  }

  async function api(path, options = {}) {
    const response = await fetch(path, {
      credentials: "same-origin",
      ...options,
      headers: {
        ...(options.headers || {}),
      },
    });

    const contentType = (response.headers.get("content-type") || "").toLowerCase();
    const raw = await response.text();

    let data = raw;
    if (contentType.includes("application/json")) {
      try {
        data = JSON.parse(raw);
      } catch {
        data = raw;
      }
    }

    if (response.status === 401) {
      const message =
        (data && typeof data === "object" && (data.error || data.message)) ||
        "Unauthorized. Please login.";

      if (isProtectedPage()) {
        window.location.replace("login.html");
      }
      throw new Error(message);
    }

    if (!response.ok) {
      const message =
        (data && typeof data === "object" && (data.error || data.message)) ||
        (data && typeof data === "object" && data.create === "fail" && data.error) ||
        (data && typeof data === "object" && data.login === "fail" && data.error) ||
        (typeof data === "string" && data.trim()) ||
        `Request failed (${response.status})`;
      throw new Error(message);
    }

    return data;
  }

  async function requireAuth() {
    const me = await api("api/me");
    setTextForSelector("[data-user-name]", me.username || "Staff User");
    setTextForSelector("[data-user-role]", me.role || "Authorized");
    return me;
  }

  function setTextForSelector(selector, value) {
    const node = document.querySelector(selector);
    if (!node) return;
    node.textContent = value;
  }

  async function initIndex() {
    const progressFill = document.querySelector("[data-progress-fill]");
    const progressValue = document.querySelector("[data-progress-value]");

    const setProgress = (value) => {
      if (progressFill) {
        progressFill.style.width = `${value}%`;
      }
      if (progressValue) {
        progressValue.textContent = `${value}%`;
      }
    };

    setProgress(45);

    try {
      await api("api/me");
      setProgress(100);
      window.setTimeout(() => window.location.replace("dashboard.html"), 250);
    } catch {
      setProgress(100);
      window.setTimeout(() => window.location.replace("login.html"), 250);
    }
  }

  async function initLogin() {
    const form = $("loginForm");
    const usernameInput = $("username");
    const passwordInput = $("password");
    const loginButton = $("btnLogin");
    const out = $("out");

    if (!form || !usernameInput || !passwordInput) return;

    try {
      const me = await api("api/me");
      if (me && me.username) {
        window.location.replace("dashboard.html");
        return;
      }
    } catch {
      // stay on login page
    }

    usernameInput.focus();

    form.addEventListener("submit", async (event) => {
      event.preventDefault();
      hidePanel("out");

      const username = usernameInput.value.trim();
      const password = passwordInput.value;

      if (!username || !password) {
        showPanel("out", "Enter username and password.");
        toast("Enter username and password.", "warn");
        return;
      }

      setBusy(loginButton, true, "Logging in...");

      try {
        await api("api/login", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ username, password }),
        });
        if (out) out.classList.add("hidden");
        toast("Login successful.", "ok");
        window.location.href = "dashboard.html";
      } catch (error) {
        showPanel("out", error.message);
        toast(error.message, "err");
      } finally {
        setBusy(loginButton, false);
      }
    });
  }

  async function initDashboard() {
    await requireAuth();

    const logoutButton = $("btnLogout");
    if (!logoutButton) return;

    logoutButton.addEventListener("click", async () => {
      setBusy(logoutButton, true, "Signing out...");
      try {
        await api("api/logout", { method: "POST" });
        toast("Logged out.", "ok");
        window.location.replace("login.html");
      } catch (error) {
        toast(error.message, "err");
        setBusy(logoutButton, false);
      }
    });
  }

  async function initAddReservation() {
    await requireAuth();
    digitsOnlyInput("contactNo");
    setupDateConstraints();

    const roomTypeSelect = $("typeId");
    const form = $("reservationForm");
    const saveButton = $("btnSave");
    const clearButton = $("btnClear");
    const output = $("out");

    if (roomTypeSelect) {
      roomTypeSelect.innerHTML = '<option disabled selected value="">Loading room types...</option>';
      try {
        const cacheKey = "ovr_room_types_v1";
        let roomTypes = null;
        const cached = sessionStorage.getItem(cacheKey);

        if (cached) {
          const parsed = JSON.parse(cached);
          if (Date.now() - parsed.t < 10 * 60 * 1000) {
            roomTypes = parsed.v;
          }
        }

        if (!roomTypes) {
          roomTypes = await api("api/room-types");
          sessionStorage.setItem(cacheKey, JSON.stringify({ t: Date.now(), v: roomTypes }));
        }

        roomTypeSelect.innerHTML = '<option disabled selected value="">Select a room type</option>';
        roomTypes.forEach((type) => {
          const option = document.createElement("option");
          option.value = String(type.typeId);
          option.textContent = `${type.typeName} (Rs. ${money(type.nightlyRate)}/night)`;
          roomTypeSelect.appendChild(option);
        });
      } catch (error) {
        roomTypeSelect.innerHTML = '<option disabled selected value="">Failed to load room types</option>';
        showPanel("formError", error.message);
        toast(error.message, "err");
      }
    }

    if (!form) return;

    form.addEventListener("submit", async (event) => {
      event.preventDefault();
      hidePanel("formError");

      const payload = {
        guestName: ($("guestName")?.value || "").trim(),
        contactNo: ($("contactNo")?.value || "").trim(),
        email: ($("email")?.value || "").trim(),
        address: ($("address")?.value || "").trim(),
        typeId: Number.parseInt($("typeId")?.value || "0", 10),
        checkIn: $("checkIn")?.value || "",
        checkOut: $("checkOut")?.value || "",
      };

      if (!payload.guestName) return showPanel("formError", "Guest Name is required.");
      if (!payload.contactNo) return showPanel("formError", "Contact Number is required.");
      if (!payload.checkIn) return showPanel("formError", "Check-in date is required.");
      if (!payload.checkOut) return showPanel("formError", "Check-out date is required.");
      if (payload.checkOut <= payload.checkIn) return showPanel("formError", "Check-out must be after Check-in.");
      if (!payload.typeId) return showPanel("formError", "Room Type is required.");

      const digits = payload.contactNo.replace(/\D/g, "");
      if (digits.length < 9) return showPanel("formError", "Contact number seems too short.");

      if (payload.email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(payload.email)) {
        return showPanel("formError", "Email format is invalid.");
      }

      setBusy(saveButton, true, "Saving...");

      try {
        const response = await api("api/reservations", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });

        const reservationId = response.reservationId;
        if (!reservationId) {
          throw new Error("Reservation created, but ID is missing.");
        }

        const formattedId = reservationCode(reservationId);
        output?.classList.remove("hidden");
        output?.classList.add("flex");
        setText("reservationIdDisplay", formattedId);

        const link = $("viewReservationLink");
        if (link) {
          link.href = `view-reservation.html#id=${reservationId}`;
        }

        toast(`Reservation saved (${formattedId}).`, "ok");
      } catch (error) {
        showPanel("formError", error.message);
        toast(error.message, "err");
      } finally {
        setBusy(saveButton, false);
      }
    });

    clearButton?.addEventListener("click", () => {
      hidePanel("formError");
      if (output) {
        output.classList.add("hidden");
        output.classList.remove("flex");
      }
    });
  }

  async function initViewReservation() {
    await requireAuth();

    const ridInput = $("rid");
    const searchButton = $("btnSearch");
    const topBillButton = $("btnBill");
    const sideBillButton = $("btnBillSide");
    const result = $("result");

    let currentReservationId = null;

    const openBill = () => {
      if (!currentReservationId) {
        toast("Load a reservation first.", "warn");
        return;
      }
      window.location.href = `bill.html#id=${currentReservationId}`;
    };

    topBillButton?.addEventListener("click", openBill);
    sideBillButton?.addEventListener("click", openBill);

    const resetView = () => {
      hidePanel("viewError");
      result?.classList.add("hidden");
      currentReservationId = null;
      if (topBillButton) topBillButton.disabled = true;
    };

    const fillReservation = (reservation) => {
      const nights = nightsBetween(reservation.checkIn, reservation.checkOut);
      const nightlyRate = Number(reservation.nightlyRate) || 0;
      const total = nights * nightlyRate;
      const guestMeta = [reservation.email, reservation.contactNo].filter(Boolean).join(" • ") || "--";

      setText("display-rid", reservation.reservationId || "--");
      setText("res-guest-name", reservation.guestName);
      setText("res-guest-email", guestMeta);
      setText("res-room-type", reservation.typeName);
      setText("res-nightly-rate", `Rs. ${money(nightlyRate)} per night`);
      setText("res-nightly-rate-copy", `Rs. ${money(nightlyRate)}`);
      setText("res-checkin", reservation.checkIn);
      setText("res-checkout", reservation.checkOut);
      setText("res-address", reservation.address || "Address not provided");
      setText("res-nights", `${nights} night${nights === 1 ? "" : "s"}`);
      setText("res-total", `Rs. ${money(total)}`);

      currentReservationId = reservation.reservationId;
      if (topBillButton) topBillButton.disabled = false;
      result?.classList.remove("hidden");
    };

    async function loadReservation(id) {
      setBusy(searchButton, true, "Searching...");
      resetView();

      try {
        const reservation = await api(`api/reservations?id=${encodeURIComponent(id)}`);
        fillReservation(reservation);
        toast("Reservation loaded.", "ok");
      } catch (error) {
        showPanel("viewError", error.message);
        toast(error.message, "err");
      } finally {
        setBusy(searchButton, false);
      }
    }

    searchButton?.addEventListener("click", () => {
      const id = (ridInput?.value || "").trim();
      if (!id) {
        showPanel("viewError", "Enter a Reservation ID.");
        toast("Enter a Reservation ID.", "warn");
        return;
      }
      void loadReservation(id);
    });

    bindEnter(ridInput, () => searchButton?.click());

    const hashId = getHashId();
    if (hashId && ridInput) {
      ridInput.value = hashId;
      await loadReservation(hashId);
    }
  }

  async function initBill() {
    await requireAuth();

    const ridInput = $("rid");
    const loadButton = $("btnLoad");
    const printButton = $("btnPrint");

    const resetInvoice = () => {
      setText("invId", "Invoice #: --");
      setText("invDate", "Date: --");
      setText("billGuestName", "Guest name");
      setText("billCheckIn", "--");
      setText("billCheckOut", "--");
      setText("billRoom", "--");
      setHtml("billGuestMeta", "Guest contact details");
      setHtml("invRows", '<tr><td class="py-8 text-center text-sm text-slate-400" colspan="4">Load a reservation bill to see invoice details.</td></tr>');
      setText("subtotal", "Rs. 0.00");
      setText("tax", "Rs. 0.00");
      setText("total", "Rs. 0.00");
      if (printButton) printButton.disabled = true;
    };

    async function loadBill(id) {
      setBusy(loadButton, true, "Loading...");
      hidePanel("invoiceError");

      try {
        const bill = await api(`api/bill?id=${encodeURIComponent(id)}`);
        const today = new Date();
        const pad = (n) => String(n).padStart(2, "0");
        const invoiceDate = `${pad(today.getDate())}/${pad(today.getMonth() + 1)}/${today.getFullYear()}`;
        const guestLines = [bill.contactNo, bill.email, bill.address].filter(Boolean).map(escapeHtml).join("<br/>") || "Guest contact details";

        setText("invId", `Invoice #: INV-${bill.reservationId}`);
        setText("invDate", `Date: ${invoiceDate}`);
        setText("billGuestName", bill.guestName || "Guest name");
        setHtml("billGuestMeta", guestLines);
        setText("billCheckIn", bill.checkIn || "--");
        setText("billCheckOut", bill.checkOut || "--");
        setText("billRoom", bill.roomType || "--");

        setHtml(
          "invRows",
          `
            <tr class="border-b border-slate-200 dark:border-slate-800">
              <td class="py-4">
                <div class="font-bold text-slate-900 dark:text-slate-100">${escapeHtml(bill.roomType || "Room")}</div>
                <div class="mt-1 text-xs text-slate-500 dark:text-slate-400">
                  Reservation ${escapeHtml(reservationCode(bill.reservationId))}<br/>
                  ${escapeHtml(bill.checkIn || "--")} → ${escapeHtml(bill.checkOut || "--")}
                </div>
              </td>
              <td class="py-4 text-center font-bold">${escapeHtml(String(bill.nights ?? 0))}</td>
              <td class="py-4 text-right font-bold">Rs. ${escapeHtml(money(bill.nightlyRate))}</td>
              <td class="py-4 text-right font-bold">Rs. ${escapeHtml(money(bill.total))}</td>
            </tr>
          `
        );

        const subtotal = Number(bill.total) || 0;
        const tax = 0;
        const total = subtotal + tax;

        setText("subtotal", `Rs. ${money(subtotal)}`);
        setText("tax", `Rs. ${money(tax)}`);
        setText("total", `Rs. ${money(total)}`);

        if (printButton) printButton.disabled = false;
        toast("Invoice loaded.", "ok");
      } catch (error) {
        resetInvoice();
        showPanel("invoiceError", error.message);
        setHtml("invRows", `<tr><td colspan="4" class="py-10 text-center font-medium text-red-500">${escapeHtml(error.message)}</td></tr>`);
        toast(error.message, "err");
      } finally {
        setBusy(loadButton, false);
      }
    }

    resetInvoice();

    loadButton?.addEventListener("click", () => {
      const id = (ridInput?.value || "").trim();
      if (!id) {
        showPanel("invoiceError", "Enter a Reservation ID.");
        toast("Enter a Reservation ID.", "warn");
        return;
      }
      void loadBill(id);
    });

    bindEnter(ridInput, () => loadButton?.click());
    printButton?.addEventListener("click", () => window.print());

    const hashId = getHashId();
    if (hashId && ridInput) {
      ridInput.value = hashId;
      await loadBill(hashId);
    }
  }

  async function boot() {
    switch (page) {
      case "":
      case "index.html":
        await initIndex();
        break;
      case "login.html":
        await initLogin();
        break;
      case "dashboard.html":
        await initDashboard();
        break;
      case "add-reservation.html":
        await initAddReservation();
        break;
      case "view-reservation.html":
        await initViewReservation();
        break;
      case "bill.html":
        await initBill();
        break;
      default:
        break;
    }
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", () => void boot());
  } else {
    void boot();
  }

  window.api = api;
  window.requireAuth = requireAuth;
})();
