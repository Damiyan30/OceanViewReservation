<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Staff Registration | HotelSys</title>
<!-- Google Fonts: Manrope -->
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@300;400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
<!-- Material Symbols -->
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<!-- Tailwind CSS with plugins -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
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
<body class="bg-background-light dark:bg-background-dark min-h-screen flex flex-col font-display">
<!-- Top Navigation Bar -->
<header class="w-full bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 px-6 lg:px-10 py-4">
<div class="max-w-7xl mx-auto flex items-center justify-between">
<div class="flex items-center gap-3">
<div class="bg-primary p-1.5 rounded-lg text-white">
<span class="material-symbols-outlined block text-2xl">apartment</span>
</div>
<h1 class="text-xl font-extrabold text-slate-900 dark:text-slate-100 tracking-tight">HotelSys</h1>
</div>
<div class="hidden md:flex items-center gap-6">
<span class="text-sm text-slate-500 dark:text-slate-400">Ocean View Resort Management</span>
<a class="text-sm font-semibold text-primary hover:text-primary/80 transition-colors" href="#">Help Center</a>
</div>
</div>
</header>
<!-- Main Content: Signup Card Container -->
<main class="flex-grow flex items-center justify-center p-6 md:p-12">
<div class="w-full max-w-[480px] bg-white dark:bg-slate-900 shadow-xl rounded-xl border border-slate-200 dark:border-slate-800 overflow-hidden">
<!-- Card Header -->
<div class="p-8 pb-0">
<div class="mb-6 flex justify-center">
<div class="size-16 rounded-full bg-primary/10 flex items-center justify-center text-primary">
<span class="material-symbols-outlined text-4xl">badge</span>
</div>
</div>
<h2 class="text-2xl font-bold text-center text-slate-900 dark:text-slate-100">Staff Registration</h2>
<p class="text-center text-slate-500 dark:text-slate-400 mt-2 text-sm leading-relaxed">
                    Join the Ocean View Resort team. Enter your professional details below.
                </p>
</div>
<!-- Signup Form -->
<form action="#" class="p-8 space-y-5">
<!-- Full Name -->
<div class="space-y-1.5">
<label class="flex items-center text-sm font-semibold text-slate-700 dark:text-slate-300">
                        Full Name <span class="text-red-500 ml-1">*</span>
</label>
<div class="relative">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-xl">person</span>
<input class="w-full pl-10 pr-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-slate-100 focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none" placeholder="John Doe" required="" type="text"/>
</div>
</div>
<!-- Staff Email -->
<div class="space-y-1.5">
<label class="flex items-center text-sm font-semibold text-slate-700 dark:text-slate-300">
                        Staff Email <span class="text-red-500 ml-1">*</span>
</label>
<div class="relative">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-xl">mail</span>
<input class="w-full pl-10 pr-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-slate-100 focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none" placeholder="name@oceanview.com" required="" type="email"/>
</div>
</div>
<!-- Staff ID (Numeric) -->
<div class="space-y-1.5">
<label class="flex items-center text-sm font-semibold text-slate-700 dark:text-slate-300">
                        Staff ID Number <span class="text-red-500 ml-1">*</span>
</label>
<div class="relative">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-xl">pin</span>
<input class="w-full pl-10 pr-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-slate-100 focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none" placeholder="Enter numeric ID" required="" type="number"/>
</div>
</div>
<!-- Password -->
<div class="space-y-1.5">
<label class="flex items-center text-sm font-semibold text-slate-700 dark:text-slate-300">
                        Password <span class="text-red-500 ml-1">*</span>
</label>
<div class="relative">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-xl">lock</span>
<input class="w-full pl-10 pr-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-slate-100 focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none" placeholder="••••••••" required="" type="password"/>
</div>
<p class="text-[11px] text-slate-500 dark:text-slate-400 italic">
                        Must be at least 8 characters with a mix of letters and numbers.
                    </p>
</div>
<!-- Confirm Password -->
<div class="space-y-1.5">
<label class="flex items-center text-sm font-semibold text-slate-700 dark:text-slate-300">
                        Confirm Password <span class="text-red-500 ml-1">*</span>
</label>
<div class="relative">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-xl">lock_reset</span>
<input class="w-full pl-10 pr-4 py-3 rounded-lg border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-slate-100 focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all outline-none" placeholder="••••••••" required="" type="password"/>
</div>
</div>
<!-- Create Account Button -->
<button class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-3.5 rounded-lg transition-all shadow-lg shadow-primary/20 active:scale-[0.98] mt-4" type="submit">
                    Create Account
                </button>
</form>
<!-- Card Footer -->
<div class="px-8 py-6 bg-slate-50 dark:bg-slate-800/50 border-t border-slate-200 dark:border-slate-800 text-center">
<p class="text-sm text-slate-600 dark:text-slate-400">
                    Already have an account? 
                    <a class="text-primary font-bold hover:underline ml-1" href="#">Log in</a>
</p>
</div>
</div>
</main>
<!-- Page Footer (Informational) -->
<footer class="p-6 text-center text-slate-400 dark:text-slate-600 text-xs">
<div class="max-w-md mx-auto flex items-center justify-center gap-4 mb-4">
<div class="h-px flex-1 bg-slate-200 dark:bg-slate-800"></div>
<span class="uppercase tracking-widest font-semibold">Security Verified</span>
<div class="h-px flex-1 bg-slate-200 dark:bg-slate-800"></div>
</div>
<p>© 2024 HotelSys Management Solutions. All Rights Reserved.</p>
<p class="mt-1">Authorized personnel only. All access is logged.</p>
</footer>
</body></html>