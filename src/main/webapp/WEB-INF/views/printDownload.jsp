<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Invoice Print and Download Flow - Ocean View Resort</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200..800&amp;display=swap" rel="stylesheet"/>
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
        @media print {
            .no-print {
                display: none !important;
            }
            .print-only {
                display: block !important;
            }
            body {
                background-color: white !important;
            }
            .invoice-container {
                box-shadow: none !important;
                border: none !important;
                margin: 0 !important;
                padding: 0 !important;
                width: 100% !important;
            }
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark font-display text-slate-900 dark:text-slate-100 min-h-screen">
<!-- Main Navigation (Background) -->
<header class="no-print bg-white dark:bg-background-dark border-b border-slate-200 dark:border-slate-800 px-4 lg:px-10 py-3 flex items-center justify-between sticky top-0 z-10">
<div class="flex items-center gap-4 text-primary">
<span class="material-symbols-outlined text-3xl">waves</span>
<h2 class="text-slate-900 dark:text-slate-100 text-lg font-bold leading-tight tracking-tight">Ocean View Resort</h2>
</div>
<div class="hidden md:flex flex-1 justify-center gap-8">
<a class="text-slate-600 dark:text-slate-400 text-sm font-medium hover:text-primary transition-colors" href="#">Dashboard</a>
<a class="text-slate-600 dark:text-slate-400 text-sm font-medium hover:text-primary transition-colors" href="#">Reservations</a>
<a class="text-primary text-sm font-bold border-b-2 border-primary" href="#">Billing</a>
<a class="text-slate-600 dark:text-slate-400 text-sm font-medium hover:text-primary transition-colors" href="#">Rooms</a>
<a class="text-slate-600 dark:text-slate-400 text-sm font-medium hover:text-primary transition-colors" href="#">Guests</a>
</div>
<div class="flex items-center gap-3">
<button class="flex items-center justify-center rounded-lg h-10 w-10 bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-400">
<span class="material-symbols-outlined">notifications</span>
</button>
<div class="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center overflow-hidden border border-primary/20">
<img alt="Profile of User" class="w-full h-full object-cover" data-alt="Professional headshot for user profile" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDyb1BJWJ44I9JGZRkE3En4togi5LjdrjkpkGbv1_5ZywkSBkcgJo228F81rS6bIffaT9kEtIFU92t6pFeLHnCstmVjljNHRVJH7BZwcR3fwijv7b2jKujISQRjQYZ1fT2jaNrLnRtmhgAM2Rou7LwwcFi0CvseU05JeqFKQFOHB4GPf8JI7ztAc1j5RP5Kr3U70-7-pmi5KfYOrPUMpAjwHH2CWPDGM4VBDucMwCioPXRJW-E5uW7oV5dVyMl7QMLl2VOFcaoNn6m5"/>
</div>
</div>
</header>
<!-- Success Toast (Background) -->
<div class="no-print fixed top-24 right-6 z-50 animate-bounce">
<div class="bg-white dark:bg-slate-800 border-l-4 border-green-500 shadow-xl rounded-lg p-4 flex items-center gap-3 min-w-[300px]">
<span class="material-symbols-outlined text-green-500">check_circle</span>
<div>
<p class="text-sm font-bold text-slate-900 dark:text-slate-100">Success</p>
<p class="text-xs text-slate-500 dark:text-slate-400">Invoice downloaded successfully</p>
</div>
<button class="ml-auto text-slate-400 hover:text-slate-600">
<span class="material-symbols-outlined text-sm">close</span>
</button>
</div>
</div>
<main class="max-w-5xl mx-auto py-8 px-4">
<!-- Breadcrumb & Actions -->
<div class="no-print flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
<div>
<h1 class="text-3xl font-black text-slate-900 dark:text-slate-100 tracking-tight">Billing Preview</h1>
<p class="text-slate-500 dark:text-slate-400">Review reservation RES-1024 details</p>
</div>
<div class="flex gap-3">
<button class="flex items-center gap-2 px-4 py-2 border border-slate-200 dark:border-slate-700 rounded-lg text-sm font-bold bg-white dark:bg-slate-800 hover:bg-slate-50 transition-colors">
<span class="material-symbols-outlined text-sm">edit</span> Edit Bill
                </button>
<button class="flex items-center gap-2 px-6 py-2 bg-primary text-white rounded-lg text-sm font-bold shadow-lg shadow-primary/20 hover:brightness-110 transition-all">
<span class="material-symbols-outlined text-sm">download</span> Download PDF
                </button>
</div>
</div>
<!-- Printable Invoice Content -->
<div class="invoice-container bg-white dark:bg-slate-900 rounded-xl shadow-2xl border border-slate-200 dark:border-slate-800 overflow-hidden mb-12">
<!-- Header Section -->
<div class="p-8 md:p-12 border-b border-slate-100 dark:border-slate-800 flex flex-col md:flex-row justify-between gap-8">
<div class="space-y-4">
<div class="flex items-center gap-2 text-primary">
<span class="material-symbols-outlined text-4xl">waves</span>
<span class="text-2xl font-black tracking-tighter text-slate-900 dark:text-slate-100">OCEAN VIEW RESORT</span>
</div>
<div class="text-sm text-slate-500 space-y-1">
<p>123 Serenity Coast Blvd</p>
<p>Malibu, California 90265</p>
<p>contact@oceanviewresort.com</p>
<p>+1 (555) 000-8888</p>
</div>
</div>
<div class="text-right space-y-2">
<h3 class="text-4xl font-light text-slate-300 dark:text-slate-700 tracking-widest uppercase">Invoice</h3>
<div class="text-sm">
<p class="text-slate-400">Invoice Number</p>
<p class="font-bold text-slate-900 dark:text-slate-100">INV-2023-1024</p>
</div>
<div class="text-sm pt-2">
<p class="text-slate-400">Date Issued</p>
<p class="font-bold text-slate-900 dark:text-slate-100">October 27, 2023</p>
</div>
</div>
</div>
<!-- Guest & Reservation Info -->
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 border-b border-slate-100 dark:border-slate-800">
<div class="p-6 border-r border-slate-100 dark:border-slate-800">
<p class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-1">Reservation ID</p>
<p class="text-sm font-bold text-slate-900 dark:text-slate-100">RES-1024</p>
</div>
<div class="p-6 border-r border-slate-100 dark:border-slate-800">
<p class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-1">Guest Name</p>
<p class="text-sm font-bold text-slate-900 dark:text-slate-100">John Doe</p>
</div>
<div class="p-6 border-r border-slate-100 dark:border-slate-800">
<p class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-1">Stay Dates</p>
<p class="text-sm font-bold text-slate-900 dark:text-slate-100">Oct 24 - Oct 27, 2023</p>
</div>
<div class="p-6">
<p class="text-[10px] uppercase tracking-widest text-slate-400 font-bold mb-1">Room Number</p>
<p class="text-sm font-bold text-slate-900 dark:text-slate-100">Deluxe Suite 402</p>
</div>
</div>
<!-- Image Header -->
<div class="h-32 w-full bg-cover bg-center relative" data-alt="Luxury hotel room interior with ocean view" style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDqsLNf0RUytVvm8xaCqwLUstG0XnzBRBgE3hOlyImuoQWLmwMhePlfU3zPm7MCYkQrXFaf8uyBEUC2AkZd0N-i8zg9tWELx2ETXXyr8a06RJ2YS2CcQxfBuD9sLkyi-G83687Yp2gEhTTD8uZsSrtni1a5N4TERd7MrP9UnRIVvHIxVXp73_v-W6NER9-xdvRy1pj9OGAzyMkPBiuU_kldC2CeB0ePCa_eHFrmE2EjGWNa6q_ycGjP4ioHT_ISEzr1RSXHQcqvRRLt');">
<div class="absolute inset-0 bg-primary/20 backdrop-blur-[1px]"></div>
<div class="absolute inset-0 flex items-center px-12">
<h4 class="text-white text-xl font-bold">Billing Breakdown</h4>
</div>
</div>
<!-- Items Table -->
<div class="p-0 overflow-x-auto">
<table class="w-full text-sm text-left">
<thead>
<tr class="bg-slate-50 dark:bg-slate-800/50 border-b border-slate-100 dark:border-slate-800">
<th class="px-8 py-4 font-bold text-slate-600 dark:text-slate-400 uppercase tracking-tight">Description</th>
<th class="px-8 py-4 font-bold text-slate-600 dark:text-slate-400 uppercase tracking-tight">Date</th>
<th class="px-8 py-4 font-bold text-slate-600 dark:text-slate-400 uppercase tracking-tight text-center">Qty</th>
<th class="px-8 py-4 font-bold text-slate-600 dark:text-slate-400 uppercase tracking-tight text-right">Amount</th>
</tr>
</thead>
<tbody class="divide-y divide-slate-100 dark:divide-slate-800">
<tr>
<td class="px-8 py-5">
<p class="font-bold text-slate-900 dark:text-slate-100">Room Charge - Deluxe Suite</p>
<p class="text-xs text-slate-500">Oceanfront view, King size bed</p>
</td>
<td class="px-8 py-5 text-slate-600 dark:text-slate-400">Oct 24, 2023</td>
<td class="px-8 py-5 text-center">3 nights</td>
<td class="px-8 py-5 text-right font-medium">$450.00</td>
</tr>
<tr>
<td class="px-8 py-5">
<p class="font-bold text-slate-900 dark:text-slate-100">Room Service - Dinner</p>
<p class="text-xs text-slate-500">Grilled Salmon, Wine Selection</p>
</td>
<td class="px-8 py-5 text-slate-600 dark:text-slate-400">Oct 25, 2023</td>
<td class="px-8 py-5 text-center">1</td>
<td class="px-8 py-5 text-right font-medium">$45.00</td>
</tr>
<tr>
<td class="px-8 py-5">
<p class="font-bold text-slate-900 dark:text-slate-100">Spa Treatment</p>
<p class="text-xs text-slate-500">Full Body Deep Tissue Massage</p>
</td>
<td class="px-8 py-5 text-slate-600 dark:text-slate-400">Oct 26, 2023</td>
<td class="px-8 py-5 text-center">1</td>
<td class="px-8 py-5 text-right font-medium">$120.00</td>
</tr>
</tbody>
</table>
</div>
<!-- Summary -->
<div class="p-8 md:p-12 flex flex-col md:flex-row justify-between items-start gap-8 bg-slate-50 dark:bg-slate-800/30">
<div class="max-w-xs space-y-2">
<p class="text-xs font-bold text-slate-400 uppercase tracking-widest">Payment Information</p>
<p class="text-sm text-slate-600 dark:text-slate-400 italic">Payments are due within 30 days. Please include the reservation ID on your transfer.</p>
</div>
<div class="w-full md:w-80 space-y-3">
<div class="flex justify-between text-sm">
<span class="text-slate-500 dark:text-slate-400">Subtotal</span>
<span class="font-bold">$615.00</span>
</div>
<div class="flex justify-between text-sm">
<span class="text-slate-500 dark:text-slate-400">Service Charge (10%)</span>
<span class="font-bold">$61.50</span>
</div>
<div class="flex justify-between text-sm border-b border-slate-200 dark:border-slate-700 pb-3">
<span class="text-slate-500 dark:text-slate-400">VAT (5%)</span>
<span class="font-bold">$30.75</span>
</div>
<div class="flex justify-between items-center pt-2">
<span class="text-lg font-black text-slate-900 dark:text-slate-100">Total Due</span>
<span class="text-2xl font-black text-primary">$707.25</span>
</div>
</div>
</div>
<!-- Footer -->
<div class="p-6 text-center border-t border-slate-100 dark:border-slate-800">
<p class="text-xs text-slate-400">Thank you for staying at Ocean View Resort. We hope to see you again soon!</p>
</div>
</div>
</main>
<!-- Modal Overlay -->
<div class="no-print fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
<div class="bg-white dark:bg-slate-900 rounded-xl shadow-2xl w-full max-w-md overflow-hidden animate-in fade-in zoom-in duration-300">
<!-- Modal Header -->
<div class="px-6 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between bg-primary/5">
<div class="flex items-center gap-2">
<span class="material-symbols-outlined text-primary">print</span>
<h3 class="text-lg font-bold text-slate-900 dark:text-slate-100">Print / Download Bill</h3>
</div>
<button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors">
<span class="material-symbols-outlined">close</span>
</button>
</div>
<!-- Modal Content -->
<div class="p-6 space-y-6">
<div class="space-y-2">
<label class="text-sm font-bold text-slate-700 dark:text-slate-300" for="filename">File Name</label>
<div class="relative">
<input class="w-full rounded-lg border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 text-sm focus:border-primary focus:ring-primary" id="filename" name="filename" type="text" value="Invoice_RES-1024_2023-10-27.pdf"/>
<span class="material-symbols-outlined absolute right-3 top-2.5 text-slate-400 text-sm">description</span>
</div>
<p class="text-[11px] text-slate-500">The file will be saved in PDF format by default.</p>
</div>
<div class="bg-slate-50 dark:bg-slate-800/50 p-4 rounded-lg border border-slate-100 dark:border-slate-800 space-y-3">
<h4 class="text-xs font-bold text-slate-400 uppercase tracking-widest">Options</h4>
<div class="flex items-center justify-between">
<span class="text-sm text-slate-700 dark:text-slate-300">Include item descriptions</span>
<div class="relative inline-flex h-5 w-9 items-center rounded-full bg-primary cursor-pointer">
<span class="inline-block h-3.5 w-3.5 translate-x-4.5 transform rounded-full bg-white transition"></span>
</div>
</div>
<div class="flex items-center justify-between">
<span class="text-sm text-slate-700 dark:text-slate-300">Apply resort theme</span>
<div class="relative inline-flex h-5 w-9 items-center rounded-full bg-primary cursor-pointer">
<span class="inline-block h-3.5 w-3.5 translate-x-4.5 transform rounded-full bg-white transition"></span>
</div>
</div>
</div>
</div>
<!-- Modal Footer -->
<div class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-800/30 flex gap-3">
<button class="flex-1 px-4 py-2 border border-slate-200 dark:border-slate-700 rounded-lg text-sm font-bold hover:bg-white dark:hover:bg-slate-800 transition-colors">
                    Cancel
                </button>
<button class="flex-1 px-4 py-2 bg-primary text-white rounded-lg text-sm font-bold flex items-center justify-center gap-2 shadow-lg shadow-primary/25 hover:brightness-110">
<svg class="animate-spin h-4 w-4 text-white" fill="none" viewbox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
<circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
<path class="opacity-75" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" fill="currentColor"></path>
</svg>
                    Generating PDF...
                </button>
</div>
</div>
</div>
</body></html>