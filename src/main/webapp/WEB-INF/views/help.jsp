<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Help &amp; Support - Ocean View Resort</title>
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<!-- Google Fonts: Manrope -->
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&amp;display=swap" rel="stylesheet"/>
<!-- Material Symbols -->
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
        body {
            font-family: 'Manrope', sans-serif;
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
<!-- Top Navigation Bar -->
<header class="sticky top-0 z-50 w-full bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
<div class="flex justify-between items-center h-16">
<!-- Logo -->
<div class="flex items-center gap-3">
<div class="p-2 bg-primary/10 rounded-lg text-primary">
<span class="material-symbols-outlined text-2xl">apartment</span>
</div>
<span class="text-xl font-bold tracking-tight text-slate-900 dark:text-white">Ocean View Resort</span>
</div>
<!-- Nav Links -->
<nav class="hidden md:flex items-center gap-8">
<a class="text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary transition-colors" href="#">Dashboard</a>
<a class="text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary transition-colors" href="#">Reservations</a>
<a class="text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary transition-colors" href="#">Billing</a>
<a class="text-sm font-semibold text-primary" href="#">Help &amp; Support</a>
</nav>
<!-- Search & Profile -->
<div class="flex items-center gap-4">
<div class="hidden sm:flex items-center bg-slate-100 dark:bg-slate-800 rounded-full px-4 py-1.5 border border-transparent focus-within:border-primary/50 transition-all">
<span class="material-symbols-outlined text-slate-400 text-xl">search</span>
<input class="bg-transparent border-none focus:ring-0 text-sm w-48 placeholder-slate-400" placeholder="Search help..." type="text"/>
</div>
<div class="h-10 w-10 rounded-full bg-slate-200 dark:bg-slate-700 overflow-hidden border-2 border-primary/20">
<img alt="Profile" data-alt="User profile picture in a circular frame" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCXFbln1c_1aG9-wQodhzEg5ajto9cY-V5qFe8TMEAPPS_Xo6ChjHuzrlc6jMUjdeDQuWWpMcnzXSabRRrkL4M1we_5jvx5s2wqdgXvkxbhn1B3X8REKfkxiX5SpG2TL4S7ClcNhkbzoFo2FkMUqTt0wIEkQc810FRSyoXb5jOSRaRjhNjins2WzylQ4kN0UsDlfz5md8Rrs7VY_pxTjCVZEcjRBWVCXb1VCVx5MiFUIJBIglUz7nWH0lM8GCC8XhAaXD_i0mvGLrrc"/>
</div>
</div>
</div>
</div>
</header>
<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
<!-- Breadcrumbs -->
<nav class="flex items-center gap-2 text-sm text-slate-500 dark:text-slate-400 mb-6">
<a class="hover:text-primary transition-colors" href="#">Home</a>
<span class="material-symbols-outlined text-xs">chevron_right</span>
<span class="font-medium text-slate-900 dark:text-slate-200">Help &amp; Support</span>
</nav>
<!-- Page Header -->
<div class="mb-10">
<h1 class="text-4xl font-extrabold text-slate-900 dark:text-white tracking-tight mb-2">Help &amp; Support</h1>
<p class="text-lg text-slate-600 dark:text-slate-400">Everything you need to manage your resort experience seamlessly.</p>
</div>
<div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
<!-- FAQ Section (Left Column) -->
<div class="lg:col-span-8 space-y-6">
<div class="flex items-center gap-2 mb-2">
<span class="material-symbols-outlined text-primary">help</span>
<h2 class="text-2xl font-bold text-slate-900 dark:text-white">Frequently Asked Questions</h2>
</div>
<div class="space-y-4">
<!-- FAQ Item 1 -->
<details class="group bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-xl overflow-hidden shadow-sm transition-all open:ring-1 open:ring-primary/30" open="">
<summary class="flex items-center justify-between p-5 cursor-pointer list-none hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
<span class="font-semibold text-slate-900 dark:text-white">How to cancel a reservation?</span>
<span class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform duration-200">expand_more</span>
</summary>
<div class="p-5 pt-0 text-slate-600 dark:text-slate-400 leading-relaxed border-t border-slate-100 dark:border-slate-800/50">
                            To cancel a reservation, navigate to the <span class="text-primary font-medium underline underline-offset-4 decoration-primary/30 cursor-pointer">Reservations</span> tab, select your specific booking, and click the 'Cancel Booking' button. Please note our 24-hour cancellation policy applies to all standard suites. Refund processing typically takes 3-5 business days.
                        </div>
</details>
<!-- FAQ Item 2 -->
<details class="group bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-xl overflow-hidden shadow-sm transition-all open:ring-1 open:ring-primary/30">
<summary class="flex items-center justify-between p-5 cursor-pointer list-none hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
<span class="font-semibold text-slate-900 dark:text-white">How to extend a stay?</span>
<span class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform duration-200">expand_more</span>
</summary>
<div class="p-5 pt-0 text-slate-600 dark:text-slate-400 leading-relaxed border-t border-slate-100 dark:border-slate-800/50">
                            Extensions depend on room availability. You can request an extension through the 'Manage Booking' screen. If your current room is unavailable, our system will suggest alternative accommodations for the additional dates.
                        </div>
</details>
<!-- FAQ Item 3 -->
<details class="group bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-xl overflow-hidden shadow-sm transition-all open:ring-1 open:ring-primary/30">
<summary class="flex items-center justify-between p-5 cursor-pointer list-none hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
<span class="font-semibold text-slate-900 dark:text-white">What payment methods are accepted?</span>
<span class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform duration-200">expand_more</span>
</summary>
<div class="p-5 pt-0 text-slate-600 dark:text-slate-400 leading-relaxed border-t border-slate-100 dark:border-slate-800/50">
                            We accept all major credit cards (Visa, MasterCard, American Express), digital wallets like Apple Pay and Google Pay, and direct bank transfers for corporate bookings. All transactions are secured using 256-bit encryption.
                        </div>
</details>
<!-- FAQ Item 4 -->
<details class="group bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-xl overflow-hidden shadow-sm transition-all open:ring-1 open:ring-primary/30">
<summary class="flex items-center justify-between p-5 cursor-pointer list-none hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
<span class="font-semibold text-slate-900 dark:text-white">How to get a VAT receipt?</span>
<span class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform duration-200">expand_more</span>
</summary>
<div class="p-5 pt-0 text-slate-600 dark:text-slate-400 leading-relaxed border-t border-slate-100 dark:border-slate-800/50">
                            VAT receipts are automatically generated once payment is completed. You can download them from the <span class="text-primary font-medium underline underline-offset-4 decoration-primary/30 cursor-pointer">Billing History</span> section in your dashboard. If you need a modified invoice for business purposes, please contact our finance team.
                        </div>
</details>
<!-- FAQ Item 5 -->
<details class="group bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-800 rounded-xl overflow-hidden shadow-sm transition-all open:ring-1 open:ring-primary/30">
<summary class="flex items-center justify-between p-5 cursor-pointer list-none hover:bg-slate-50 dark:hover:bg-slate-800/50 transition-colors">
<span class="font-semibold text-slate-900 dark:text-white">How to reset my password?</span>
<span class="material-symbols-outlined text-slate-400 group-open:rotate-180 transition-transform duration-200">expand_more</span>
</summary>
<div class="p-5 pt-0 text-slate-600 dark:text-slate-400 leading-relaxed border-t border-slate-100 dark:border-slate-800/50">
                            Click on your profile icon, go to 'Account Settings', and select 'Security'. From there, you can update your password. If you are locked out, use the 'Forgot Password' link on the login page to receive a reset link via email.
                        </div>
</details>
</div>
<!-- Support Category Cards -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-12">
<div class="p-6 bg-primary/5 dark:bg-primary/10 rounded-2xl border border-primary/10">
<span class="material-symbols-outlined text-primary text-3xl mb-3">payments</span>
<h3 class="font-bold text-slate-900 dark:text-white mb-1">Billing Support</h3>
<p class="text-sm text-slate-600 dark:text-slate-400">Invoices, refunds, and payment issues.</p>
</div>
<div class="p-6 bg-primary/5 dark:bg-primary/10 rounded-2xl border border-primary/10">
<span class="material-symbols-outlined text-primary text-3xl mb-3">calendar_month</span>
<h3 class="font-bold text-slate-900 dark:text-white mb-1">Booking Help</h3>
<p class="text-sm text-slate-600 dark:text-slate-400">Modifying stays or group bookings.</p>
</div>
<div class="p-6 bg-primary/5 dark:bg-primary/10 rounded-2xl border border-primary/10">
<span class="material-symbols-outlined text-primary text-3xl mb-3">security</span>
<h3 class="font-bold text-slate-900 dark:text-white mb-1">Account Safety</h3>
<p class="text-sm text-slate-600 dark:text-slate-400">Privacy, data, and access control.</p>
</div>
</div>
</div>
<!-- Sidebar (Right Column) -->
<div class="lg:col-span-4 space-y-6">
<!-- Contact Form Card -->
<section class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 shadow-sm p-6">
<h3 class="text-xl font-bold text-slate-900 dark:text-white mb-4">Send us a message</h3>
<form action="#" class="space-y-4">
<div>
<label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1">Subject</label>
<select class="w-full rounded-lg border-slate-300 dark:border-slate-700 dark:bg-slate-800 focus:ring-primary focus:border-primary text-sm">
<option>General Inquiry</option>
<option>Billing Issue</option>
<option>Reservation Change</option>
<option>Technical Feedback</option>
</select>
</div>
<div>
<label class="block text-sm font-semibold text-slate-700 dark:text-slate-300 mb-1">Message</label>
<textarea class="w-full rounded-lg border-slate-300 dark:border-slate-700 dark:bg-slate-800 focus:ring-primary focus:border-primary text-sm" placeholder="How can we help you today?" rows="4"></textarea>
</div>
<button class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-3 px-4 rounded-lg transition-all flex items-center justify-center gap-2" type="button">
<span class="material-symbols-outlined text-lg">send</span>
                            Send Message
                        </button>
</form>
</section>
<!-- Resort Contact Info Card -->
<section class="bg-slate-900 text-white rounded-2xl shadow-xl p-6 relative overflow-hidden">
<!-- Decorative Circle -->
<div class="absolute -right-8 -bottom-8 w-32 h-32 bg-primary/20 rounded-full blur-3xl"></div>
<h3 class="text-xl font-bold mb-6 relative z-10">Resort Contact Info</h3>
<div class="space-y-5 relative z-10">
<div class="flex items-start gap-4">
<div class="bg-white/10 p-2 rounded-lg">
<span class="material-symbols-outlined text-primary">phone_in_talk</span>
</div>
<div>
<p class="text-xs text-slate-400 uppercase tracking-wider font-bold">Call Us</p>
<p class="text-lg font-medium">+1 (800) OCEAN-VW</p>
</div>
</div>
<div class="flex items-start gap-4">
<div class="bg-white/10 p-2 rounded-lg">
<span class="material-symbols-outlined text-primary">mail</span>
</div>
<div>
<p class="text-xs text-slate-400 uppercase tracking-wider font-bold">Email Us</p>
<p class="text-lg font-medium">support@oceanview.com</p>
</div>
</div>
<div class="flex items-start gap-4">
<div class="bg-white/10 p-2 rounded-lg">
<span class="material-symbols-outlined text-primary">location_on</span>
</div>
<div>
<p class="text-xs text-slate-400 uppercase tracking-wider font-bold">Visit Us</p>
<p class="text-base leading-snug">777 Coastal Drive,<br/>Pacific Harbor, CA 90210</p>
</div>
</div>
</div>
<!-- Small Map/Location Badge -->
<div class="mt-8 rounded-xl overflow-hidden h-32 bg-slate-800 relative">
<div class="absolute inset-0 opacity-40 grayscale" data-alt="Stylized map showing resort location" data-location="Pacific Harbor" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuA9949qkEMJvWscXf3opZUZZkr1Rqrk0eB7JRSANRHo7YTvELQoFqH25PHBMbe6TVhy1KNsZ56cQqfh1O4gApPMWs03KNoOBakd1vPXhHWEEe7tSoaF_4YcCAmE5Kooc8e6w4N3RRaUDsBPivU0v1earmciBO9L1V2Wj2x9-y1gKhwmMYYhz-w0slhg2IrDQkid2vMEZsIWDpdSKctqsrN-XVSAATE38pnESu_JKATw_Hm1d9v_mLOrCdwglYiAKDWGRSMEeyfjZ3sV'); background-size: cover;"></div>
<div class="absolute inset-0 flex items-center justify-center">
<div class="bg-primary p-2 rounded-full shadow-lg ring-4 ring-primary/20 animate-pulse">
<span class="material-symbols-outlined text-white">pin_drop</span>
</div>
</div>
</div>
</section>
<!-- Help Tip Card -->
<div class="p-5 bg-amber-50 dark:bg-amber-900/10 border border-amber-200 dark:border-amber-900/30 rounded-2xl flex gap-4">
<span class="material-symbols-outlined text-amber-500">lightbulb</span>
<div>
<h4 class="text-sm font-bold text-amber-900 dark:text-amber-200 mb-1">Quick Tip</h4>
<p class="text-xs text-amber-800/80 dark:text-amber-400/80">Check your email for the "Reservation ID" before contacting support for faster resolution.</p>
</div>
</div>
</div>
</div>
</main>
<footer class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 mt-12 border-t border-slate-200 dark:border-slate-800">
<div class="flex flex-col md:flex-row justify-between items-center gap-6">
<div class="text-slate-500 dark:text-slate-400 text-sm">
                © 2024 Ocean View Resort. All rights reserved.
            </div>
<div class="flex gap-8 text-sm font-semibold text-slate-600 dark:text-slate-300">
<a class="hover:text-primary transition-colors" href="#">Privacy Policy</a>
<a class="hover:text-primary transition-colors" href="#">Terms of Service</a>
<a class="hover:text-primary transition-colors" href="#">Cookies</a>
</div>
</div>
</footer>
</body></html>