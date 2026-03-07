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
      button.classList.add("opacity-70", "cursor-wait");
      button.innerHTML = `<span>${escapeHtml(busyLabel)}</span>`;
      return;
    }

    button.disabled = false;
    button.classList.remove("opacity-70", "cursor-wait");
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
      <div id="ovrToastCard" class="rounded-xl border border-slate-700 bg-slate-950/90 px-5 py-3 text-sm font-medium text-slate-100 shadow-xl backdrop-blur">
        <span id="ovrToastMsg">Message</span>
      </div>
    `;
    document.body.appendChild(toast);
  }

  function toast(message, type = "info") {
    ensureToast();
    const wrap = $("ovrToast");
    const card = $("ovrToastCard");
    const text = $("ovrToastMsg");
    if (!wrap || !card || !text) return;

    text.textContent = message;
    card.className = "rounded-xl border bg-slate-950/90 px-5 py-3 text-sm font-medium text-slate-100 shadow-xl backdrop-blur";

    if (type === "ok") {
      card.classList.add("border-emerald-500/40");
    } else if (type === "err") {
      card.classList.add("border-red-500/40");
    } else if (type === "warn") {
      card.classList.add("border-amber-500/40");
    } else {
      card.classList.add("border-slate-700");
    }

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
        (data && typeof data === "object" && data.update === "fail" && data.error) ||
        (typeof data === "string" && data.trim()) ||
        `Request failed (${response.status})`;
      throw new Error(message);
    }

    return data;
  }

  async function requireAuth() {
    const me = await api("api/me");
    setTextForSelector("[data-user-name]", me.username || "Staff User");
    setTextForSelector("[data-user-role]", me.role || "Authorized User");
    return me;
  }

  function setTextForSelector(selector, value) {
    const node = document.querySelector(selector);
    if (!node) return;
    node.textContent = value;
  }
function formatLongDate(isoDate) {
  if (!isoDate) return "--";
  const date = new Date(isoDate);
  if (Number.isNaN(date.getTime())) return isoDate;

  return date.toLocaleDateString(undefined, {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}

function renderDashboardStats(data) {
  setText("dashboardTodayDate", formatLongDate(data.today));
  setText("statTotalReservations", data.totalReservations ?? 0, "0");
  setText("statTodayCheckIns", data.todayCheckIns ?? 0, "0");
  setText("statTodayCheckOuts", data.todayCheckOuts ?? 0, "0");
  setText("statActiveStays", data.activeStays ?? 0, "0");

  const tableBody = $("recentReservationsBody");
  if (!tableBody) return;

  const recentReservations = Array.isArray(data.recentReservations) ? data.recentReservations : [];

  if (!recentReservations.length) {
    tableBody.innerHTML = '<tr><td class="px-4 py-8 text-center text-slate-400" colspan="5">No recent reservations found.</td></tr>';
    return;
  }

  tableBody.innerHTML = recentReservations
    .map((reservation) => {
      const nights = nightsBetween(reservation.checkIn, reservation.checkOut);
      return `
        <tr class="hover:bg-slate-900/20">
          <td class="px-4 py-4 font-bold text-primary">${escapeHtml(reservationCode(reservation.reservationId))}</td>
          <td class="px-4 py-4">
            <div class="font-semibold text-white">${escapeHtml(reservation.guestName || "--")}</div>
            <div class="text-xs text-slate-400">${escapeHtml(reservation.contactNo || "--")}</div>
          </td>
          <td class="px-4 py-4 text-slate-300">${escapeHtml(reservation.typeName || "--")}</td>
          <td class="px-4 py-4 text-slate-300">
            <div>${escapeHtml(reservation.checkIn || "--")} → ${escapeHtml(reservation.checkOut || "--")}</div>
            <div class="text-xs text-slate-400">${escapeHtml(String(nights))} night${nights === 1 ? "" : "s"}</div>
          </td>
          <td class="px-4 py-4 text-right">
            <a class="inline-flex rounded-lg bg-primary px-3 py-2 text-xs font-bold text-slate-900 transition-opacity hover:opacity-90"
               href="view-reservation.html#id=${encodeURIComponent(reservation.reservationId)}">
              Open
            </a>
          </td>
        </tr>
      `;
    })
    .join("");
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

  async function loadDashboardStats() {
    hidePanel("dashboardError");

    try {
      const data = await api("api/dashboard/stats");
      renderDashboardStats(data);
    } catch (error) {
      showPanel("dashboardError", error.message);
      toast(error.message, "err");
    }
  }

  if (logoutButton) {
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

  await loadDashboardStats();
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

      if (!payload.guestName) return showPanel("formError", "Guest name is required.");
      if (!payload.contactNo) return showPanel("formError", "Contact number is required.");
      if (!payload.checkIn) return showPanel("formError", "Check-in date is required.");
      if (!payload.checkOut) return showPanel("formError", "Check-out date is required.");
      if (payload.checkOut <= payload.checkIn) return showPanel("formError", "Check-out must be after check-in.");
      if (!payload.typeId) return showPanel("formError", "Room type is required.");

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
    const refreshButton = $("btnRefreshList");
    const topBillButton = $("btnBill");
    const sideBillButton = $("btnBillSide");
    const result = $("result");
    const tableBody = $("reservationsTableBody");
    const editForm = $("editReservationForm");
    const updateButton = $("btnUpdateReservation");
    const deleteButton = $("btnDeleteReservation");
    const editTypeSelect = $("editTypeId");
    const editCheckIn = $("editCheckIn");
    const editCheckOut = $("editCheckOut");

    let currentReservationId = null;
    let roomTypes = [];

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
      hidePanel("editError");
      result?.classList.add("hidden");
      currentReservationId = null;
      setText("summary-current-id", "--");
      setText("summary-current-nights", "--");
      setText("summary-current-room", "--");
      if (topBillButton) topBillButton.disabled = true;
    };

    const renderTable = (reservations) => {
      setText("summary-total-reservations", reservations.length);

      if (!tableBody) return;

      if (!reservations.length) {
        tableBody.innerHTML = '<tr><td class="px-4 py-8 text-center text-slate-400" colspan="6">No reservations found.</td></tr>';
        return;
      }

      tableBody.innerHTML = reservations
        .map((reservation) => {
          const nights = nightsBetween(reservation.checkIn, reservation.checkOut);
          return `
            <tr class="hover:bg-slate-50/80 dark:hover:bg-slate-800/40">
              <td class="px-4 py-4 font-bold text-primary">#${escapeHtml(String(reservation.reservationId))}</td>
              <td class="px-4 py-4">
                <div class="font-semibold">${escapeHtml(reservation.guestName || "--")}</div>
                <div class="text-xs text-slate-500 dark:text-slate-400">${escapeHtml(reservation.email || "No email")}</div>
              </td>
              <td class="px-4 py-4">${escapeHtml(reservation.contactNo || "--")}</td>
              <td class="px-4 py-4">${escapeHtml(reservation.typeName || "--")}</td>
              <td class="px-4 py-4">
                <div>${escapeHtml(reservation.checkIn || "--")} → ${escapeHtml(reservation.checkOut || "--")}</div>
                <div class="text-xs text-slate-500 dark:text-slate-400">${escapeHtml(String(nights))} night${nights === 1 ? "" : "s"}</div>
              </td>
              <td class="px-4 py-4">
                <div class="flex justify-end gap-2">
                  <button class="rounded-lg bg-primary px-3 py-2 text-xs font-bold text-slate-900 transition-opacity hover:opacity-90" data-action="load" data-id="${escapeHtml(String(reservation.reservationId))}" type="button">Load</button>
                  <button class="rounded-lg bg-red-500 px-3 py-2 text-xs font-bold text-white transition-opacity hover:opacity-90" data-action="delete" data-id="${escapeHtml(String(reservation.reservationId))}" type="button">Delete</button>
                </div>
              </td>
            </tr>
          `;
        })
        .join("");
    };

    const loadRoomTypes = async () => {
      const cacheKey = "ovr_room_types_v1";
      const cached = sessionStorage.getItem(cacheKey);

      if (cached) {
        try {
          const parsed = JSON.parse(cached);
          if (Date.now() - parsed.t < 10 * 60 * 1000 && Array.isArray(parsed.v)) {
            roomTypes = parsed.v;
          }
        } catch {
          roomTypes = [];
        }
      }

      if (!roomTypes.length) {
        roomTypes = await api("api/room-types");
        sessionStorage.setItem(cacheKey, JSON.stringify({ t: Date.now(), v: roomTypes }));
      }

      if (editTypeSelect) {
        editTypeSelect.innerHTML = '<option value="">Select a room type</option>';
        roomTypes.forEach((type) => {
          const option = document.createElement("option");
          option.value = String(type.typeId);
          option.textContent = `${type.typeName} (Rs. ${money(type.nightlyRate)}/night)`;
          editTypeSelect.appendChild(option);
        });
      }
    };

    const fillReservation = (reservation) => {
      const nights = nightsBetween(reservation.checkIn, reservation.checkOut);
      const nightlyRate = Number(reservation.nightlyRate) || 0;
      const total = nights * nightlyRate;
      const guestMeta = [reservation.email, reservation.contactNo].filter(Boolean).join(" | ") || "--";

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
      setText("summary-current-id", reservation.reservationId || "--");
      setText("summary-current-nights", nights || "--");
      setText("summary-current-room", reservation.typeName || "--");

      currentReservationId = reservation.reservationId;
      if (topBillButton) topBillButton.disabled = false;
      result?.classList.remove("hidden");
    };

    const fillEditForm = (reservation) => {
      if ($("editReservationId")) $("editReservationId").value = reservation.reservationId || "";
      if ($("editGuestName")) $("editGuestName").value = reservation.guestName || "";
      if ($("editContactNo")) $("editContactNo").value = reservation.contactNo || "";
      if ($("editEmail")) $("editEmail").value = reservation.email || "";
      if ($("editAddress")) $("editAddress").value = reservation.address || "";
      if (editTypeSelect) editTypeSelect.value = String(reservation.typeId || "");
      if (editCheckIn) editCheckIn.value = reservation.checkIn || "";
      if (editCheckOut) editCheckOut.value = reservation.checkOut || "";
    };

    async function loadReservation(id) {
      setBusy(searchButton, true, "Searching...");
      hidePanel("viewError");
      hidePanel("editError");

      try {
        const reservation = await api(`api/reservations?id=${encodeURIComponent(id)}`);
        fillReservation(reservation);
        fillEditForm(reservation);
        if (ridInput) ridInput.value = String(id);
        toast("Reservation loaded.", "ok");
      } catch (error) {
        resetView();
        showPanel("viewError", error.message);
        toast(error.message, "err");
      } finally {
        setBusy(searchButton, false);
      }
    }

    async function loadReservationList() {
      if (refreshButton) setBusy(refreshButton, true, "Refreshing...");
      hidePanel("viewError");

      try {
        const reservations = await api("api/reservations");
        renderTable(Array.isArray(reservations) ? reservations : []);
      } catch (error) {
        if (tableBody) {
          tableBody.innerHTML = `<tr><td class="px-4 py-8 text-center text-red-500" colspan="6">${escapeHtml(error.message)}</td></tr>`;
        }
        showPanel("viewError", error.message);
        toast(error.message, "err");
      } finally {
        if (refreshButton) setBusy(refreshButton, false);
      }
    }

    async function deleteReservation(id) {
      if (!window.confirm(`Delete reservation #${id}? This cannot be undone.`)) {
        return;
      }

      if (deleteButton) setBusy(deleteButton, true, "Deleting...");

      try {
        await api(`api/reservations?id=${encodeURIComponent(id)}`, { method: "DELETE" });
        if (String(currentReservationId) === String(id)) {
          resetView();
          if (ridInput) ridInput.value = "";
        }
        await loadReservationList();
        toast("Reservation deleted.", "ok");
      } catch (error) {
        showPanel("viewError", error.message);
        toast(error.message, "err");
      } finally {
        if (deleteButton) setBusy(deleteButton, false);
      }
    }

    refreshButton?.addEventListener("click", () => {
      void loadReservationList();
    });

    searchButton?.addEventListener("click", () => {
      const id = (ridInput?.value || "").trim();
      if (!id) {
        showPanel("viewError", "Enter a reservation ID.");
        toast("Enter a reservation ID.", "warn");
        return;
      }
      void loadReservation(id);
    });

    bindEnter(ridInput, () => searchButton?.click());

    tableBody?.addEventListener("click", (event) => {
      const button = event.target.closest("button[data-action]");
      if (!button) return;

      const { action, id } = button.dataset;
      if (!id) return;

      if (action === "load") {
        void loadReservation(id);
      } else if (action === "delete") {
        void deleteReservation(id);
      }
    });

    editCheckIn?.addEventListener("change", () => {
      if (!editCheckIn.value || !editCheckOut) return;
      editCheckOut.min = editCheckIn.value;
      if (editCheckOut.value && editCheckOut.value <= editCheckIn.value) {
        editCheckOut.value = "";
      }
    });

    editForm?.addEventListener("submit", async (event) => {
      event.preventDefault();
      hidePanel("editError");

      const payload = {
        reservationId: Number.parseInt($("editReservationId")?.value || "0", 10),
        guestName: ($("editGuestName")?.value || "").trim(),
        contactNo: ($("editContactNo")?.value || "").trim(),
        email: ($("editEmail")?.value || "").trim(),
        address: ($("editAddress")?.value || "").trim(),
        typeId: Number.parseInt(editTypeSelect?.value || "0", 10),
        checkIn: editCheckIn?.value || "",
        checkOut: editCheckOut?.value || "",
      };

      if (!payload.reservationId) return showPanel("editError", "Reservation id is missing.");
      if (!payload.guestName) return showPanel("editError", "Guest name is required.");
      if (!payload.contactNo) return showPanel("editError", "Contact number is required.");
      if (!payload.typeId) return showPanel("editError", "Room type is required.");
      if (!payload.checkIn) return showPanel("editError", "Check-in date is required.");
      if (!payload.checkOut) return showPanel("editError", "Check-out date is required.");
      if (payload.checkOut <= payload.checkIn) return showPanel("editError", "Check-out must be after check-in.");

      const digits = payload.contactNo.replace(/\D/g, "");
      if (digits.length < 9) return showPanel("editError", "Contact number seems too short.");
      if (payload.email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(payload.email)) {
        return showPanel("editError", "Email format is invalid.");
      }

      setBusy(updateButton, true, "Updating...");

      try {
        await api("api/reservations", {
          method: "PUT",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload),
        });

        await loadReservation(payload.reservationId);
        await loadReservationList();
        toast("Reservation updated.", "ok");
      } catch (error) {
        showPanel("editError", error.message);
        toast(error.message, "err");
      } finally {
        setBusy(updateButton, false);
      }
    });

    deleteButton?.addEventListener("click", () => {
      const id = $("editReservationId")?.value || currentReservationId;
      if (!id) {
        toast("Load a reservation first.", "warn");
        return;
      }
      void deleteReservation(id);
    });

    digitsOnlyInput("rid");
    digitsOnlyInput("editContactNo");
    await loadRoomTypes();
    await loadReservationList();

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
                  ${escapeHtml(bill.checkIn || "--")} to ${escapeHtml(bill.checkOut || "--")}
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
        showPanel("invoiceError", "Enter a reservation ID.");
        toast("Enter a reservation ID.", "warn");
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