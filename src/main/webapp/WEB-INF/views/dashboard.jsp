<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Staff Dashboard Overview - HotelSys</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200;300;400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#137fec",
                        "background-light": "#f6f7f8",
                        "background-dark": "#101922",
                    },
                    fontFamily: {
                        "display": ["Manrope", "sans-serif"]
                    },
                    borderRadius: {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                },
            },
        }
    </script>
<style>
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: .5; }
        }
        .animate-skeleton {
            animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 antialiased">
<!-- Sticky Top Navigation -->
<nav class="sticky top-0 z-50 w-full bg-white dark:bg-background-dark border-b border-slate-200 dark:border-slate-800">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
<div class="flex justify-between h-16">
<div class="flex items-center gap-8">
<!-- Logo Section -->
<div class="flex items-center gap-3">
<div class="size-8 bg-primary rounded-lg flex items-center justify-center text-white">
<span class="material-symbols-outlined text-xl">hotel</span>
</div>
<h1 class="text-xl font-bold tracking-tight text-slate-900 dark:text-white">Ocean View Resort</h1>
</div>
<!-- Desktop Nav Links -->
<div class="hidden md:flex items-center gap-6">
<a class="text-primary font-semibold border-b-2 border-primary h-16 flex items-center px-1" href="#">Dashboard</a>
<a class="text-slate-500 hover:text-slate-900 dark:text-slate-400 dark:hover:text-white transition-colors" href="#">Reservations</a>
<a class="text-slate-500 hover:text-slate-900 dark:text-slate-400 dark:hover:text-white transition-colors" href="#">Billing</a>
<a class="text-slate-500 hover:text-slate-900 dark:text-slate-400 dark:hover:text-white transition-colors" href="#">Reports</a>
</div>
</div>
<!-- Right Side Actions -->
<div class="flex items-center gap-4">
<div class="relative hidden lg:block">
<span class="absolute inset-y-0 left-0 pl-3 flex items-center text-slate-400">
<span class="material-symbols-outlined text-sm">search</span>
</span>
<input class="block w-64 pl-10 pr-3 py-2 border border-slate-200 dark:border-slate-700 rounded-lg bg-slate-50 dark:bg-slate-800 focus:ring-primary focus:border-primary text-sm" placeholder="Search guests or rooms..." type="text"/>
</div>
<button class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full relative">
<span class="material-symbols-outlined">notifications</span>
<span class="absolute top-2 right-2 size-2 bg-red-500 rounded-full border-2 border-white dark:border-background-dark"></span>
</button>
<button class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full">
<span class="material-symbols-outlined">settings</span>
</button>
<div class="h-8 w-px bg-slate-200 dark:border-slate-700"></div>
<div class="flex items-center gap-3 pl-2">
<div class="text-right hidden sm:block">
<p class="text-sm font-bold text-slate-900 dark:text-white leading-none">Sarah Jenkins</p>
<p class="text-xs text-slate-500 dark:text-slate-400">Front Desk Manager</p>
</div>
<div class="size-10 rounded-full bg-slate-200 overflow-hidden border-2 border-white dark:border-slate-700 shadow-sm">
<img alt="Staff Avatar" class="w-full h-full object-cover" data-alt="Close up portrait of a professional woman" src="https://lh3.googleusercontent.com/aida-public/AB6AXuA1PbyV5vjGCIjxSeUlVWklerIbGp61HuLPpMUVR6MUBWOzQjYkmzWfLMkqD_5Nh20ql1nXPFF-K1G5k6QFXbUkJ8JYPN-ALavIBQ2_0uFWEe9HJS_QNc-nZebl0DXBazzs3egYBBXck6t-0RvkLgA1IZyjignaEXGC2HNOYwPUxKN25VLN3VpHAmbY-LHOVYrF8crYp6BsBkQhFOL6UwL0vSNt5DZK7OpAKGlLwiZjyqXypHKjkLhvs_F24YuOB2pvVYk0YDtSD2mV"/>
</div>
</div>
</div>
</div>
</div>
</nav>
<!-- Main Dashboard Area -->
<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
<!-- Welcome Header -->
<div class="mb-10">
<h2 class="text-3xl font-extrabold text-slate-900 dark:text-white">Welcome, Staff Member</h2>
<div class="flex items-center gap-2 mt-2 text-slate-500 dark:text-slate-400">
<span class="material-symbols-outlined text-sm">calendar_today</span>
<span class="text-sm font-medium">Friday, October 27, 2023</span>
<span class="mx-2 text-slate-300">•</span>
<span class="material-symbols-outlined text-sm">schedule</span>
<span class="text-sm font-medium">Shift: Morning (08:00 - 16:00)</span>
</div>
</div>
<!-- Quick Action Grid -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
<!-- Add Reservation -->
<button class="group relative flex flex-col p-6 bg-white dark:bg-background-dark border border-slate-200 dark:border-slate-800 rounded-xl shadow-sm hover:shadow-md hover:border-primary transition-all text-left">
<div class="size-12 rounded-lg bg-primary/10 text-primary flex items-center justify-center mb-4 group-hover:bg-primary group-hover:text-white transition-colors">
<span class="material-symbols-outlined text-2xl">person_add</span>
</div>
<h3 class="text-lg font-bold text-slate-900 dark:text-white">Add Reservation</h3>
<p class="text-slate-500 dark:text-slate-400 text-sm mt-1">Check availability and create new guest bookings instantly.</p>
<div class="mt-4 flex items-center text-primary font-bold text-sm">
                    Create New Stay
                    <span class="material-symbols-outlined ml-1 text-sm group-hover:translate-x-1 transition-transform">arrow_forward</span>
</div>
</button>
<!-- View Reservations -->
<button class="group relative flex flex-col p-6 bg-white dark:bg-background-dark border border-slate-200 dark:border-slate-800 rounded-xl shadow-sm hover:shadow-md hover:border-primary transition-all text-left">
<div class="size-12 rounded-lg bg-emerald-50 text-emerald-600 flex items-center justify-center mb-4 group-hover:bg-emerald-600 group-hover:text-white transition-colors">
<span class="material-symbols-outlined text-2xl">book_online</span>
</div>
<h3 class="text-lg font-bold text-slate-900 dark:text-white">View Reservations</h3>
<p class="text-slate-500 dark:text-slate-400 text-sm mt-1">Manage existing stays, update dates, or cancel bookings.</p>
<div class="mt-4 flex items-center text-emerald-600 font-bold text-sm">
                    Guest List
                    <span class="material-symbols-outlined ml-1 text-sm group-hover:translate-x-1 transition-transform">arrow_forward</span>
</div>
</button>
<!-- Generate Bill -->
<button class="group relative flex flex-col p-6 bg-white dark:bg-background-dark border border-slate-200 dark:border-slate-800 rounded-xl shadow-sm hover:shadow-md hover:border-primary transition-all text-left">
<div class="size-12 rounded-lg bg-amber-50 text-amber-600 flex items-center justify-center mb-4 group-hover:bg-amber-600 group-hover:text-white transition-colors">
<span class="material-symbols-outlined text-2xl">receipt_long</span>
</div>
<h3 class="text-lg font-bold text-slate-900 dark:text-white">Generate Bill</h3>
<p class="text-slate-500 dark:text-slate-400 text-sm mt-1">Process check-outs, apply service fees, and issue invoices.</p>
<div class="mt-4 flex items-center text-amber-600 font-bold text-sm">
                    Payment Gateway
                    <span class="material-symbols-outlined ml-1 text-sm group-hover:translate-x-1 transition-transform">arrow_forward</span>
</div>
</button>
</div>
<!-- Summary Insights -->
<div class="mb-4 flex items-center justify-between">
<h2 class="text-xl font-bold text-slate-900 dark:text-white tracking-tight">At a Glance</h2>
<div class="flex items-center gap-1 text-slate-400 text-xs">
<span class="material-symbols-outlined text-xs animate-spin-slow">sync</span>
                Auto-updating every 30s
            </div>
</div>
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
<!-- Today's Check-ins -->
<div class="p-6 bg-white dark:bg-background-dark border border-slate-200 dark:border-slate-800 rounded-xl shadow-sm">
<div class="flex justify-between items-start mb-4">
<p class="text-sm font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Today's Check-ins</p>
<span class="px-2 py-1 bg-emerald-50 text-emerald-600 text-[10px] font-bold rounded-lg">+12% vs Yesterday</span>
</div>
<div class="flex items-baseline gap-2">
<p class="text-4xl font-black text-slate-900 dark:text-white leading-none">24</p>
<p class="text-sm text-slate-400 font-medium">Guests</p>
</div>
<div class="mt-6 pt-4 border-t border-slate-50 dark:border-slate-800">
<div class="flex items-center justify-between text-sm">
<span class="text-slate-500">Remaining</span>
<span class="font-bold text-slate-900 dark:text-white">9 / 24</span>
</div>
<div class="w-full bg-slate-100 dark:bg-slate-800 h-1.5 rounded-full mt-2 overflow-hidden">
<div class="bg-primary h-full w-[62%] rounded-full"></div>
</div>
</div>
</div>
<!-- Today's Check-outs (Skeleton Loading State) -->
<div class="p-6 bg-white dark:bg-background-dark border border-slate-200 dark:border-slate-800 rounded-xl shadow-sm">
<div class="flex justify-between items-start mb-4">
<p class="text-sm font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Today's Check-outs</p>
<div class="h-4 w-12 bg-slate-200 dark:bg-slate-800 rounded animate-skeleton"></div>
</div>
<div class="flex items-baseline gap-2">
<div class="h-10 w-16 bg-slate-200 dark:bg-slate-800 rounded-lg animate-skeleton"></div>
<div class="h-4 w-12 bg-slate-100 dark:bg-slate-800 rounded animate-skeleton"></div>
</div>
<div class="mt-6 pt-4 border-t border-slate-50 dark:border-slate-800">
<div class="space-y-2">
<div class="h-3 w-full bg-slate-100 dark:bg-slate-800 rounded animate-skeleton"></div>
<div class="h-3 w-2/3 bg-slate-100 dark:bg-slate-800 rounded animate-skeleton"></div>
</div>
</div>
</div>
<!-- Active Reservations -->
<div class="p-6 bg-white dark:bg-background-dark border border-slate-200 dark:border-slate-800 rounded-xl shadow-sm">
<div class="flex justify-between items-start mb-4">
<p class="text-sm font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Occupancy Rate</p>
<span class="px-2 py-1 bg-primary/10 text-primary text-[10px] font-bold rounded-lg">High Demand</span>
</div>
<div class="flex items-baseline gap-2">
<p class="text-4xl font-black text-slate-900 dark:text-white leading-none">92%</p>
<p class="text-sm text-slate-400 font-medium">118 / 128 Rooms</p>
</div>
<div class="mt-6 pt-4 border-t border-slate-50 dark:border-slate-800">
<div class="flex -space-x-2 overflow-hidden mb-2">
<div class="inline-block size-6 rounded-full border-2 border-white dark:border-background-dark bg-slate-200 overflow-hidden"><img alt="Occupant" class="size-full object-cover" data-alt="Portrait of a young person" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBmGPkaADhEqSIPSq0bOG5Y4sp_967gpDa40jR-mHEnNZOtq0uJo4qYlk6rQTNg2f6HXU4XKKERrytzvv1912XAZztys__q3Jan1EcuCmBTg2Af-HcJ4rEpqX00dZzkQdr497evC3UEFyvTxRJfWJvMmfCx_4RBOlVP8mFcZ-oP_AJ7y8pM-k3m7y4N04B6PhJtrPpxt6OG14ev6L-TSHa3i485X4sR9m85VQm2WkbTOA7vzrLaAqO9Wr0LX88lpZFVEMWx4ZaTkjJ3"/></div>
<div class="inline-block size-6 rounded-full border-2 border-white dark:border-background-dark bg-slate-200 overflow-hidden"><img alt="Occupant" class="size-full object-cover" data-alt="Portrait of a man in a sweater" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCXchqppuatRyq5T3B8JImr9qvxDKzxhJD__NsnZMcG3N_oohXw2Xg9tR3UuK47tb8MUbjztfnju0R3ZwQbrWvgHMYNxD2qVo7AMlJViKq7FpQp3D3naoTaMonbZZUEoSp-NYD8qP0Eee5cmESc_mU4aUZpOlB6kVqE6jWDGYZsKwI_6U1-HkysBbhMRjsYrP50YLKkx92r4dJI4hk2gCbNF5dvdbtG0gk8BZ1GPxfymfrf5T6Y_qwKWNHpaw9yInhvbYvAmxh-Qo55"/></div>
<div class="inline-block size-6 rounded-full border-2 border-white dark:border-background-dark bg-slate-200 overflow-hidden"><img alt="Occupant" class="size-full object-cover" data-alt="Portrait of a woman smiling" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBmPmoJ2G1m8BJDbh9j5lbLxun84JHGyxP4BO5AdVsDVZt74KN4WRoErs0DoQaBRoPoVtY2ycWK8dBraSB-pYLphn6IybO3S5rRRW49VrpGy6tZdh7h7itrH8yCAwyHTt0vYGxHYWBrCzlPcOb1FTAtvS2C2MLrJjOfLJ7gLvCoMEkLz57AckndbzVMi8oiAeV4G9gqddASDN1ImM2MD85M82ESpoWpxvuGwT_vkyplTdpGxOfJDiuuRLul2nKKet4lyVy5BgIA4hNr"/></div>
<div class="flex size-6 items-center justify-center rounded-full border-2 border-white dark:border-background-dark bg-slate-100 text-[8px] font-bold text-slate-500">+115</div>
</div>
<p class="text-xs text-slate-400">Current guests in-house</p>
</div>
</div>
</div>
<!-- Recent Activity Feed (Optional extra for completeness) -->
<div class="mt-12">
<h2 class="text-xl font-bold text-slate-900 dark:text-white tracking-tight mb-6">Recent System Log</h2>
<div class="bg-white dark:bg-background-dark border border-slate-200 dark:border-slate-800 rounded-xl overflow-hidden">
<div class="p-4 border-b border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-800/50 flex justify-between items-center">
<span class="text-sm font-bold text-slate-500">Latest Operations</span>
<button class="text-xs font-bold text-primary hover:underline">View All Logs</button>
</div>
<div class="divide-y divide-slate-100 dark:divide-slate-800">
<div class="p-4 flex gap-4 items-center">
<div class="size-8 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center">
<span class="material-symbols-outlined text-lg">edit_note</span>
</div>
<div class="flex-1">
<p class="text-sm text-slate-900 dark:text-white font-medium">Reservation Updated</p>
<p class="text-xs text-slate-500">Room 402 - Guest: Arthur Morgan • By Staff Jenkins</p>
</div>
<span class="text-xs text-slate-400 font-medium">2 mins ago</span>
</div>
<div class="p-4 flex gap-4 items-center">
<div class="size-8 rounded-full bg-emerald-100 text-emerald-600 flex items-center justify-center">
<span class="material-symbols-outlined text-lg">check_circle</span>
</div>
<div class="flex-1">
<p class="text-sm text-slate-900 dark:text-white font-medium">Check-in Completed</p>
<p class="text-xs text-slate-500">Room 105 - Guest: Sadie Adler • Digital Key Issued</p>
</div>
<span class="text-xs text-slate-400 font-medium">15 mins ago</span>
</div>
<div class="p-4 flex gap-4 items-center">
<div class="size-8 rounded-full bg-amber-100 text-amber-600 flex items-center justify-center">
<span class="material-symbols-outlined text-lg">payments</span>
</div>
<div class="flex-1">
<p class="text-sm text-slate-900 dark:text-white font-medium">Invoice Generated</p>
<p class="text-xs text-slate-500">Room 312 - $450.00 • Pending Payment</p>
</div>
<span class="text-xs text-slate-400 font-medium">28 mins ago</span>
</div>
</div>
</div>
</div>
</main>
<!-- Footer -->
<footer class="mt-auto py-8 border-t border-slate-200 dark:border-slate-800 bg-white dark:bg-background-dark">
<div class="max-w-7xl mx-auto px-4 text-center">
<p class="text-sm text-slate-500 dark:text-slate-400">© 2023 Ocean View Resort &amp; Spa • HotelSys v2.4.0-staff</p>
<div class="flex justify-center gap-4 mt-4 text-xs text-slate-400">
<a class="hover:text-primary transition-colors" href="#">System Health</a>
<span>|</span>
<a class="hover:text-primary transition-colors" href="#">Technical Support</a>
<span>|</span>
<a class="hover:text-primary transition-colors" href="#">Privacy Policy</a>
</div>
</div>
</footer>
</body></html>