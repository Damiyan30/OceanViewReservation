<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Billing and Invoice Generation - Ocean View Resort</title>
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
        body {
            font-family: 'Manrope', sans-serif;
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
<!-- Navigation -->
<header class="border-b border-slate-200 dark:border-slate-800 bg-white dark:bg-slate-900 sticky top-0 z-50">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
<div class="flex justify-between h-16 items-center">
<div class="flex items-center gap-4">
<div class="bg-primary text-white p-2 rounded-lg flex items-center justify-center">
<span class="material-symbols-outlined">apartment</span>
</div>
<h1 class="text-xl font-extrabold tracking-tight">Ocean View Resort</h1>
</div>
<nav class="hidden md:flex space-x-8">
<a class="text-slate-600 dark:text-slate-400 hover:text-primary font-medium text-sm transition-colors" href="#">Reservations</a>
<a class="text-slate-600 dark:text-slate-400 hover:text-primary font-medium text-sm transition-colors" href="#">Rooms</a>
<a class="text-primary font-bold text-sm border-b-2 border-primary pb-5 mt-5" href="#">Billing</a>
<a class="text-slate-600 dark:text-slate-400 hover:text-primary font-medium text-sm transition-colors" href="#">Guests</a>
</nav>
<div class="flex items-center gap-4">
<button class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full transition-colors">
<span class="material-symbols-outlined">notifications</span>
</button>
<div class="h-8 w-8 rounded-full bg-slate-200 dark:bg-slate-700 flex items-center justify-center overflow-hidden border border-slate-300 dark:border-slate-600">
<img alt="User Profile" data-alt="User profile picture in a circle" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDQhHRLHsuXmOyb37tZ4YRXwc43rEY3LUiQCeR3MqtqkXFtGxaAGaCQuijTQ3DCr8UNvInMV1vJANwISFNm9yMFMDZPl9-H-Q8CmpmUB8ZEOF2KGiWs3GSEArMYxpYug7cKWj-7_JNKtq_xQo_72_ckl1d3Pa6LkgqKI-D4IpbuuaMjgNpkwuFqT_BCbK4O9GFw_hBvnZZhziD36BdjP0aRKaPjkvooGj22PkXtaUufR7T9MuW7NhPcw0UhXNpHuxHcsWFI_bAHlmfD"/>
</div>
</div>
</div>
</div>
</header>
<main class="max-w-5xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
<!-- Breadcrumbs -->
<nav class="flex mb-6 text-sm font-medium text-slate-500 dark:text-slate-400 items-center gap-2">
<a class="hover:text-primary" href="#">Dashboard</a>
<span class="material-symbols-outlined text-xs">chevron_right</span>
<span class="text-slate-900 dark:text-slate-100 font-bold">Generate Bill</span>
</nav>
<!-- Page Heading -->
<div class="mb-8">
<h2 class="text-3xl font-black text-slate-900 dark:text-slate-100 tracking-tight">Generate Bill</h2>
<p class="text-slate-600 dark:text-slate-400 mt-1">Search for a reservation to finalize billing details and process payments.</p>
</div>
<!-- Search Section -->
<div class="bg-white dark:bg-slate-900 rounded-xl shadow-sm border border-slate-200 dark:border-slate-800 p-6 mb-8">
<div class="grid grid-cols-1 md:grid-cols-3 gap-6 items-end">
<div class="md:col-span-2 space-y-2">
<label class="block text-sm font-bold text-slate-700 dark:text-slate-300" for="reservation-id">Reservation ID / Guest Name</label>
<div class="relative">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
<input class="w-full pl-10 pr-4 py-3 bg-slate-50 dark:bg-slate-800 border-slate-200 dark:border-slate-700 rounded-lg focus:ring-2 focus:ring-primary focus:border-primary text-slate-900 dark:text-white transition-all" id="reservation-id" name="reservation-id" placeholder="e.g. RES-1002 or John Doe" type="text"/>
</div>
</div>
<div>
<button class="w-full bg-primary hover:bg-primary/90 text-white font-bold py-3.5 px-6 rounded-lg transition-all flex items-center justify-center gap-2 shadow-lg shadow-primary/20">
<span class="material-symbols-outlined text-xl">calculate</span>
                        Calculate Total
                    </button>
</div>
</div>
<!-- Quick Suggestion (Mock Autocomplete) -->
<div class="mt-4 flex flex-wrap gap-2 items-center">
<span class="text-xs font-bold text-slate-400 uppercase tracking-wider">Recent Checks:</span>
<button class="text-xs bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 px-3 py-1 rounded-full text-slate-600 dark:text-slate-300 border border-slate-200 dark:border-slate-700 transition-colors">RES-1002 (Alice Johnson)</button>
<button class="text-xs bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 px-3 py-1 rounded-full text-slate-600 dark:text-slate-300 border border-slate-200 dark:border-slate-700 transition-colors">RES-0988 (Mark Smith)</button>
</div>
</div>
<!-- Billing Breakdown Card -->
<div class="bg-white dark:bg-slate-900 rounded-xl shadow-xl border border-slate-200 dark:border-slate-800 overflow-hidden">
<!-- Guest Header Summary -->
<div class="p-6 border-b border-slate-200 dark:border-slate-800 bg-slate-50/50 dark:bg-slate-800/50 flex flex-wrap justify-between items-start gap-4">
<div>
<h3 class="text-lg font-extrabold text-slate-900 dark:text-slate-100">Reservation Details</h3>
<p class="text-sm text-slate-500 dark:text-slate-400">Confirmed stay for <strong>Alice Johnson</strong></p>
</div>
<div class="text-right">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-400">
                        Active Stay
                    </span>
<p class="text-xs text-slate-400 mt-1 uppercase font-bold tracking-widest">RES-1002</p>
</div>
</div>
<!-- Details Grid -->
<div class="grid grid-cols-2 md:grid-cols-4 gap-6 p-6 border-b border-slate-200 dark:border-slate-800">
<div class="space-y-1">
<p class="text-xs font-bold text-slate-400 uppercase tracking-tighter">Room Number</p>
<p class="font-bold text-slate-900 dark:text-slate-100">Deluxe Suite - 402</p>
</div>
<div class="space-y-1">
<p class="text-xs font-bold text-slate-400 uppercase tracking-tighter">Check-in</p>
<p class="font-bold text-slate-900 dark:text-slate-100">Oct 12, 2023</p>
</div>
<div class="space-y-1">
<p class="text-xs font-bold text-slate-400 uppercase tracking-tighter">Check-out</p>
<p class="font-bold text-slate-900 dark:text-slate-100">Oct 15, 2023</p>
</div>
<div class="space-y-1">
<p class="text-xs font-bold text-slate-400 uppercase tracking-tighter">Total Nights</p>
<p class="font-bold text-slate-900 dark:text-slate-100">3 Nights</p>
</div>
</div>
<!-- Itemized Table -->
<div class="p-6">
<table class="w-full text-left">
<thead>
<tr class="text-xs font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 dark:border-slate-800">
<th class="py-3 px-2">Description</th>
<th class="py-3 px-2 text-center">Qty / Days</th>
<th class="py-3 px-2 text-right">Rate</th>
<th class="py-3 px-2 text-right">Amount</th>
</tr>
</thead>
<tbody class="divide-y divide-slate-100 dark:divide-slate-800 text-sm">
<tr>
<td class="py-4 px-2">
<p class="font-bold text-slate-900 dark:text-slate-100">Room Rate (Deluxe Suite)</p>
<p class="text-xs text-slate-500">Standard seasonal rate</p>
</td>
<td class="py-4 px-2 text-center font-medium">3</td>
<td class="py-4 px-2 text-right font-medium">$250.00</td>
<td class="py-4 px-2 text-right font-bold text-slate-900 dark:text-slate-100">$750.00</td>
</tr>
<tr>
<td class="py-4 px-2">
<p class="font-bold text-slate-900 dark:text-slate-100">Room Service</p>
<p class="text-xs text-slate-500">Dinner on Oct 13 (Order #452)</p>
</td>
<td class="py-4 px-2 text-center font-medium">1</td>
<td class="py-4 px-2 text-right font-medium">$45.50</td>
<td class="py-4 px-2 text-right font-bold text-slate-900 dark:text-slate-100">$45.50</td>
</tr>
<tr>
<td class="py-4 px-2">
<p class="font-bold text-slate-900 dark:text-slate-100">Laundry Services</p>
<p class="text-xs text-slate-500">Express dry cleaning</p>
</td>
<td class="py-4 px-2 text-center font-medium">1</td>
<td class="py-4 px-2 text-right font-medium">$22.00</td>
<td class="py-4 px-2 text-right font-bold text-slate-900 dark:text-slate-100">$22.00</td>
</tr>
</tbody>
</table>
</div>
<!-- Totals Section -->
<div class="bg-slate-50 dark:bg-slate-800/30 p-8">
<div class="max-w-xs ml-auto space-y-3">
<div class="flex justify-between text-sm text-slate-600 dark:text-slate-400">
<span>Subtotal:</span>
<span class="font-bold text-slate-900 dark:text-slate-100">$817.50</span>
</div>
<div class="flex justify-between text-sm text-slate-600 dark:text-slate-400">
<span>Taxes (VAT 10%):</span>
<span class="font-bold text-slate-900 dark:text-slate-100">$81.75</span>
</div>
<div class="flex justify-between text-sm text-slate-600 dark:text-slate-400">
<span>Service Charge:</span>
<span class="font-bold text-slate-900 dark:text-slate-100">$15.00</span>
</div>
<div class="pt-4 border-t border-slate-200 dark:border-slate-700 flex justify-between items-baseline">
<span class="text-lg font-black text-slate-900 dark:text-slate-100">Total Amount:</span>
<span class="text-3xl font-black text-primary tracking-tight">$914.25</span>
</div>
</div>
</div>
</div>
<!-- Action Buttons -->
<div class="mt-8 flex flex-col sm:flex-row justify-end gap-4">
<button class="flex items-center justify-center gap-2 px-6 py-3 border-2 border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-300 font-bold rounded-lg hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">
<span class="material-symbols-outlined">restart_alt</span>
                Reset Search
            </button>
<button class="flex items-center justify-center gap-2 px-6 py-3 border-2 border-primary text-primary font-bold rounded-lg hover:bg-primary/5 transition-colors">
<span class="material-symbols-outlined">picture_as_pdf</span>
                Download PDF
            </button>
<button class="flex items-center justify-center gap-2 px-8 py-3 bg-primary text-white font-bold rounded-lg hover:bg-primary/90 transition-all shadow-lg shadow-primary/20">
<span class="material-symbols-outlined">print</span>
                Finalize &amp; Print Bill
            </button>
</div>
</main>
<!-- Success Toast (Mock) -->
<div class="fixed bottom-6 right-6 flex items-center gap-3 bg-slate-900 dark:bg-primary text-white px-5 py-4 rounded-xl shadow-2xl animate-bounce-short">
<span class="material-symbols-outlined text-green-400">check_circle</span>
<div class="text-sm">
<p class="font-bold">Total Calculated Successfully</p>
<p class="opacity-80 text-xs text-slate-300">Invoice ready for printing.</p>
</div>
<button class="ml-4 opacity-50 hover:opacity-100">
<span class="material-symbols-outlined text-sm">close</span>
</button>
</div>
<style>
        @keyframes bounce-short {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }
        .animate-bounce-short {
            animation: bounce-short 2s ease-in-out infinite;
        }
    </style>
</body></html>