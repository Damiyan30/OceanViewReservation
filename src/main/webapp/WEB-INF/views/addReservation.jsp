<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Add New Reservation - Ocean View Resort</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&amp;display=swap" rel="stylesheet"/>
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
        body {
            font-family: 'Manrope', sans-serif;
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark min-h-screen text-slate-900 dark:text-slate-100">
<!-- Top Navigation Bar -->
<header class="sticky top-0 z-50 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 px-6 lg:px-20 py-3">
<div class="max-w-7xl mx-auto flex items-center justify-between">
<div class="flex items-center gap-8">
<div class="flex items-center gap-3 text-primary">
<div class="size-8 bg-primary/10 rounded-lg flex items-center justify-center">
<span class="material-symbols-outlined text-primary">hotel</span>
</div>
<h1 class="text-slate-900 dark:text-white text-xl font-bold tracking-tight">Ocean View Resort</h1>
</div>
<nav class="hidden md:flex items-center gap-6">
<a class="text-slate-600 dark:text-slate-400 hover:text-primary dark:hover:text-primary text-sm font-semibold transition-colors" href="#">Dashboard</a>
<a class="text-primary text-sm font-semibold border-b-2 border-primary pb-1" href="#">Reservations</a>
<a class="text-slate-600 dark:text-slate-400 hover:text-primary dark:hover:text-primary text-sm font-semibold transition-colors" href="#">Rooms</a>
<a class="text-slate-600 dark:text-slate-400 hover:text-primary dark:hover:text-primary text-sm font-semibold transition-colors" href="#">Billing</a>
</nav>
</div>
<div class="flex items-center gap-4">
<div class="relative hidden sm:block">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
<input class="pl-10 pr-4 py-2 bg-slate-100 dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary w-64" placeholder="Search guests..." type="text"/>
</div>
<button class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-400">
<span class="material-symbols-outlined">notifications</span>
</button>
<div class="size-9 rounded-full bg-slate-200 dark:bg-slate-700 overflow-hidden border border-slate-300 dark:border-slate-600">
<img class="w-full h-full object-cover" data-alt="User profile picture for dashboard access" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDn2HVNBNIYPK-zPayTCy-4JRlLQFsP1L5dmqN_G9Qm3QzTTSLfPHwT77BWWTLUxFYlngwrwXXd7fNS9z47WKr7ZMGx6qG5xf22rnQ608bPp-BFbMtJpvJ-e3T66ge7k1gwDDuMDRVfxoy2ZCRy-N43gQGTPntpX4ekApP3ONmjEwM7k70EFPrnXM7xgvGdJHnk2D7hNZKzAo8TRndDHHGRWSVH5Jn9dBwr1jeexZC-Jp98eA4Kudvh1lDcf9PlXj97IMjVMwnmOS6o"/>
</div>
</div>
</div>
</header>
<main class="max-w-4xl mx-auto px-6 py-10">
<!-- Breadcrumbs -->
<nav class="flex items-center gap-2 text-sm text-slate-500 mb-6">
<a class="hover:text-primary" href="#">Home</a>
<span class="material-symbols-outlined text-xs">chevron_right</span>
<a class="hover:text-primary" href="#">Reservations</a>
<span class="material-symbols-outlined text-xs">chevron_right</span>
<span class="text-slate-900 dark:text-slate-100 font-medium">Add New Reservation</span>
</nav>
<!-- Page Header -->
<div class="mb-8">
<h2 class="text-3xl font-extrabold text-slate-900 dark:text-white tracking-tight">Add New Reservation</h2>
<p class="text-slate-600 dark:text-slate-400 mt-2">Complete the form below to register a new guest and book their stay.</p>
</div>
<!-- Success Toast (Always visible for demonstration as per prompt) -->
<div class="fixed top-24 right-6 z-50 animate-bounce">
<div class="bg-emerald-500 text-white px-6 py-3 rounded-xl shadow-lg shadow-emerald-500/20 flex items-center gap-3 border border-emerald-400">
<span class="material-symbols-outlined">check_circle</span>
<span class="font-semibold text-sm">Reservation saved successfully</span>
<button class="ml-2 hover:opacity-75 transition-opacity">
<span class="material-symbols-outlined text-sm">close</span>
</button>
</div>
</div>
<!-- Main Form Card -->
<div class="bg-white dark:bg-slate-900 rounded-xl shadow-sm border border-slate-200 dark:border-slate-800 overflow-hidden">
<form action="#" class="divide-y divide-slate-100 dark:divide-slate-800">
<!-- Section: Guest Details -->
<div class="p-8">
<div class="flex items-center gap-2 mb-6 text-primary">
<span class="material-symbols-outlined">person</span>
<h3 class="text-lg font-bold text-slate-900 dark:text-white">Guest Details</h3>
</div>
<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
<div class="space-y-2">
<label class="block text-sm font-semibold text-slate-700 dark:text-slate-300">Full Name</label>
<div class="relative">
<input class="w-full pl-4 pr-10 py-3 rounded-lg border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 focus:ring-2 focus:ring-primary focus:border-primary transition-all text-slate-900 dark:text-white placeholder:text-slate-400" placeholder="e.g. John Doe" required="" type="text"/>
<span class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-emerald-500 text-xl">check_circle</span>
</div>
</div>
<div class="space-y-2">
<label class="block text-sm font-semibold text-slate-700 dark:text-slate-300">NIC / ID Number</label>
<input class="w-full px-4 py-3 rounded-lg border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 focus:ring-2 focus:ring-primary focus:border-primary transition-all text-slate-900 dark:text-white placeholder:text-slate-400" placeholder="e.g. 199012345678" required="" type="text"/>
</div>
<div class="space-y-2">
<label class="block text-sm font-semibold text-slate-700 dark:text-slate-300">Phone Number</label>
<div class="relative">
<input class="w-full px-4 py-3 rounded-lg border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 focus:ring-2 focus:ring-primary focus:border-primary transition-all text-slate-900 dark:text-white placeholder:text-slate-400" placeholder="+1 (555) 000-0000" required="" type="tel"/>
</div>
</div>
<div class="space-y-2">
<label class="block text-sm font-semibold text-slate-700 dark:text-slate-300">Email Address</label>
<div class="relative">
<input class="w-full px-4 py-3 rounded-lg border border-red-300 dark:border-red-900 bg-white dark:bg-slate-800 focus:ring-2 focus:ring-red-500 transition-all text-slate-900 dark:text-white placeholder:text-slate-400" placeholder="john@example.com" type="email"/>
<p class="mt-1 text-xs text-red-500 flex items-center gap-1">
<span class="material-symbols-outlined text-[14px]">error</span> Please enter a valid email
                                </p>
</div>
</div>
</div>
</div>
<!-- Section: Reservation Details -->
<div class="p-8">
<div class="flex items-center gap-2 mb-6 text-primary">
<span class="material-symbols-outlined">calendar_today</span>
<h3 class="text-lg font-bold text-slate-900 dark:text-white">Reservation Details</h3>
</div>
<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
<div class="space-y-2">
<label class="block text-sm font-semibold text-slate-700 dark:text-slate-300">Room Type</label>
<select class="w-full px-4 py-3 rounded-lg border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 focus:ring-2 focus:ring-primary focus:border-primary transition-all text-slate-900 dark:text-white">
<option value="single">Single Room - $80/night</option>
<option selected="" value="double">Double Deluxe - $120/night</option>
<option value="suite">Executive Suite - $250/night</option>
<option value="family">Family Room - $180/night</option>
</select>
</div>
<div class="space-y-2">
<label class="block text-sm font-semibold text-slate-700 dark:text-slate-300">Number of Guests</label>
<input class="w-full px-4 py-3 rounded-lg border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 focus:ring-2 focus:ring-primary focus:border-primary transition-all text-slate-900 dark:text-white" max="10" min="1" type="number" value="2"/>
</div>
<div class="space-y-2">
<label class="block text-sm font-semibold text-slate-700 dark:text-slate-300">Check-in Date</label>
<input class="w-full px-4 py-3 rounded-lg border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 focus:ring-2 focus:ring-primary focus:border-primary transition-all text-slate-900 dark:text-white" type="date" value="2024-05-20"/>
</div>
<div class="space-y-2">
<label class="block text-sm font-semibold text-slate-700 dark:text-slate-300">Check-out Date</label>
<input class="w-full px-4 py-3 rounded-lg border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 focus:ring-2 focus:ring-primary focus:border-primary transition-all text-slate-900 dark:text-white" type="date" value="2024-05-21"/>
</div>
</div>
</div>
<!-- Footer: Actions -->
<div class="p-8 bg-slate-50 dark:bg-slate-800/50 flex flex-col sm:flex-row items-center justify-between gap-4">
<div class="text-sm text-slate-500 dark:text-slate-400 italic">
                        Fields marked with * are required.
                    </div>
<div class="flex items-center gap-3 w-full sm:w-auto">
<button class="w-full sm:w-auto px-6 py-3 text-slate-700 dark:text-slate-300 font-bold text-sm bg-white dark:bg-slate-900 border border-slate-300 dark:border-slate-700 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors" type="reset">
                            Clear Form
                        </button>
<button class="w-full sm:w-auto px-10 py-3 bg-primary text-white font-bold text-sm rounded-lg hover:bg-primary/90 shadow-lg shadow-primary/20 transition-all flex items-center justify-center gap-2" type="submit">
<span class="material-symbols-outlined text-xl">save</span>
                            Save Reservation
                        </button>
</div>
</div>
</form>
</div>
<!-- System Footer Info -->
<footer class="mt-12 text-center text-slate-400 text-xs">
<p>© 2024 Ocean View Resort Hotel Reservation &amp; Billing System. Designed for performance.</p>
</footer>
</main>
</body></html>