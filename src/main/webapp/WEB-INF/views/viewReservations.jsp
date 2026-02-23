<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>Manage and Search Reservations - Ocean View Resort</title>
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
        .skeleton {
            background: linear-gradient(90deg, #f0f2f4 25%, #e2e8f0 50%, #f0f2f4 75%);
            background-size: 200% 100%;
            animation: shimmer 1.5s infinite;
        }
        @keyframes shimmer {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
<!-- Top Navigation Bar -->
<header class="sticky top-0 z-50 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800">
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
<div class="flex justify-between h-16 items-center">
<div class="flex items-center gap-4">
<div class="bg-primary p-1.5 rounded-lg text-white">
<span class="material-symbols-outlined text-2xl">apartment</span>
</div>
<h2 class="text-lg font-extrabold tracking-tight text-slate-900 dark:text-white">Ocean View Resort</h2>
</div>
<nav class="hidden md:flex space-x-8">
<a class="text-slate-500 hover:text-primary px-1 pt-1 text-sm font-medium" href="#">Dashboard</a>
<a class="text-primary border-b-2 border-primary px-1 pt-1 text-sm font-semibold" href="#">Reservations</a>
<a class="text-slate-500 hover:text-primary px-1 pt-1 text-sm font-medium" href="#">Rooms</a>
<a class="text-slate-500 hover:text-primary px-1 pt-1 text-sm font-medium" href="#">Billing</a>
</nav>
<div class="flex items-center gap-3">
<button class="p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg">
<span class="material-symbols-outlined">notifications</span>
</button>
<div class="h-8 w-8 rounded-full bg-primary/20 flex items-center justify-center overflow-hidden border border-primary/30">
<img alt="User Avatar" class="h-full w-full object-cover" data-alt="Staff member profile avatar" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCKFnwKneXfhotfufwN7QtwgAFjVYjBiq59i26xgJ0vfVHo2q0W9j4t6tHPszKKrjDzSKHvKindQfn0Bk2XQ0bfSQdlJpEPJJQn7GLUwDl51I-aJlW1ZRa1kdZf6zbvtzXgNWaliVtNcYP7db1VddnXsp12Abc3GnnX4CmGK8ZDvSqbxwKH9EBFkZsCeEP7udU54DfMgFjmYf03U24lNpzhcvbLEpXxjN17P43zBAAzMyAIJoa1XMbdPwQSmRy_CL7e-JuMwtEHH26n"/>
</div>
</div>
</div>
</div>
</header>
<main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
<!-- Page Header -->
<div class="mb-8">
<h1 class="text-3xl font-black text-slate-900 dark:text-white tracking-tight">Manage Reservations</h1>
<p class="text-slate-500 dark:text-slate-400 mt-1">Easily find, filter, and manage guest bookings across the resort.</p>
</div>
<!-- Search and Filter Section -->
<div class="bg-white dark:bg-slate-900 rounded-xl shadow-sm border border-slate-200 dark:border-slate-800 p-6 mb-8">
<div class="grid grid-cols-1 md:grid-cols-4 gap-4">
<!-- Search Input -->
<div class="md:col-span-2">
<label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Search Guest or ID</label>
<div class="relative">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">search</span>
<input class="w-full pl-10 pr-4 py-2.5 bg-slate-50 dark:bg-slate-800 border-none rounded-lg focus:ring-2 focus:ring-primary text-sm" placeholder="e.g. RES-1024 or John Doe" type="text"/>
</div>
</div>
<!-- Room Type Filter -->
<div>
<label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Room Type</label>
<select class="w-full py-2.5 bg-slate-50 dark:bg-slate-800 border-none rounded-lg focus:ring-2 focus:ring-primary text-sm appearance-none">
<option>All Types</option>
<option>Suite</option>
<option>Deluxe</option>
<option>Standard</option>
</select>
</div>
<!-- Status Filter -->
<div>
<label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-2">Status</label>
<select class="w-full py-2.5 bg-slate-50 dark:bg-slate-800 border-none rounded-lg focus:ring-2 focus:ring-primary text-sm">
<option>All Statuses</option>
<option>Checked-in</option>
<option>Pending</option>
<option>Cancelled</option>
</select>
</div>
</div>
</div>
<!-- Data Table Section -->
<div class="bg-white dark:bg-slate-900 rounded-xl shadow-sm border border-slate-200 dark:border-slate-800 overflow-hidden">
<div class="overflow-x-auto">
<table class="w-full text-left border-collapse">
<thead>
<tr class="bg-slate-50 dark:bg-slate-800/50 border-b border-slate-200 dark:border-slate-800">
<th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Reservation ID</th>
<th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Guest</th>
<th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Room</th>
<th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Check-in</th>
<th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Check-out</th>
<th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider">Status</th>
<th class="px-6 py-4 text-xs font-bold text-slate-500 uppercase tracking-wider text-right">Actions</th>
</tr>
</thead>
<tbody class="divide-y divide-slate-100 dark:divide-slate-800">
<!-- Row 1 -->
<tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
<td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-primary">RES-1024</td>
<td class="px-6 py-4 whitespace-nowrap">
<div class="flex items-center gap-3">
<div class="size-8 rounded-full bg-slate-200 dark:bg-slate-700 overflow-hidden">
<img alt="John Doe" class="size-full" data-alt="John Doe profile headshot" src="https://lh3.googleusercontent.com/aida-public/AB6AXuAWef0Qn68LbCHEeqV3LPbkJiOA_1HHRTv-TeAsj-09RJNIbZ_YaJjeQj2iRnTb4GWNl4SThzLLozmpg3kwCzzbZGwARAgIk1bAmBKKlC8T01DSmP4kClDF_ohWOrSNRblJSnx3NEJA3kJ9ASs4H97QivjTWkbWqJIpV3ruUY5sMek9l3eOMQYi0-XHOThrJSKRBdFaRB5qjewH6c-iaUZxyaLBsLP3H6Ivb5vzEn8g8g7_KE0wFZ8FnIXpcBMv3rJghc3-JxSOJwdM"/>
</div>
<span class="text-sm font-semibold text-slate-700 dark:text-slate-200">John Doe</span>
</div>
</td>
<td class="px-6 py-4 whitespace-nowrap">
<span class="px-2.5 py-1 rounded bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 text-xs font-bold uppercase">Suite</span>
</td>
<td class="px-6 py-4 whitespace-nowrap text-sm text-slate-600 dark:text-slate-400">Oct 24, 2023</td>
<td class="px-6 py-4 whitespace-nowrap text-sm text-slate-600 dark:text-slate-400">Oct 26, 2023</td>
<td class="px-6 py-4 whitespace-nowrap">
<span class="flex items-center gap-1.5 text-emerald-600 dark:text-emerald-400 text-xs font-bold px-2 py-1 rounded-full bg-emerald-50 dark:bg-emerald-900/20 w-fit">
<span class="size-1.5 rounded-full bg-emerald-600"></span>
                                    Checked-in
                                </span>
</td>
<td class="px-6 py-4 whitespace-nowrap text-right space-x-2">
<button class="inline-flex items-center px-3 py-1.5 bg-primary text-white text-xs font-bold rounded hover:bg-primary/90 transition-all">
                                    View
                                </button>
<button class="inline-flex items-center px-3 py-1.5 bg-rose-50 text-rose-600 text-xs font-bold rounded hover:bg-rose-100 transition-all border border-rose-100">
                                    Cancel
                                </button>
</td>
</tr>
<!-- Row 2 -->
<tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
<td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-primary">RES-1025</td>
<td class="px-6 py-4 whitespace-nowrap">
<div class="flex items-center gap-3">
<div class="size-8 rounded-full bg-slate-200 dark:bg-slate-700 overflow-hidden">
<img alt="Sarah Smith" class="size-full" data-alt="Sarah Smith profile headshot" src="https://lh3.googleusercontent.com/aida-public/AB6AXuCMcTmbzA2rfFzBDdODhna7bDPfoLZK35fwr7LMtBtLAiK9aQBsBTCn9Jky_Pa-0-PbZ0uDZmxiYZdhOJZ0I2NFC77F4R24jlcVC5wbUuT55HG5u4lrh2a_-0KiGdz8cW7GfRLX2Ms2zQnKjpLg1qtcLNTCj6iR_rIdKM4Onm02mS9jKVpCZktME-kdHO-DM7HY4S0rc_ivHTk3s8HHvSE3ThkT2X7aDBbvALCfUt4LcrLZCOdE6kfV2w8P42-6prl7M9TQBT8_cUts"/>
</div>
<span class="text-sm font-semibold text-slate-700 dark:text-slate-200">Sarah Smith</span>
</div>
</td>
<td class="px-6 py-4 whitespace-nowrap">
<span class="px-2.5 py-1 rounded bg-purple-50 dark:bg-purple-900/20 text-purple-600 dark:text-purple-400 text-xs font-bold uppercase">Deluxe</span>
</td>
<td class="px-6 py-4 whitespace-nowrap text-sm text-slate-600 dark:text-slate-400">Oct 25, 2023</td>
<td class="px-6 py-4 whitespace-nowrap text-sm text-slate-600 dark:text-slate-400">Oct 30, 2023</td>
<td class="px-6 py-4 whitespace-nowrap">
<span class="flex items-center gap-1.5 text-amber-600 dark:text-amber-400 text-xs font-bold px-2 py-1 rounded-full bg-amber-50 dark:bg-amber-900/20 w-fit">
<span class="size-1.5 rounded-full bg-amber-600"></span>
                                    Pending
                                </span>
</td>
<td class="px-6 py-4 whitespace-nowrap text-right space-x-2">
<button class="inline-flex items-center px-3 py-1.5 bg-primary text-white text-xs font-bold rounded hover:bg-primary/90 transition-all">
                                    View
                                </button>
<button class="inline-flex items-center px-3 py-1.5 bg-rose-50 text-rose-600 text-xs font-bold rounded hover:bg-rose-100 transition-all border border-rose-100">
                                    Cancel
                                </button>
</td>
</tr>
<!-- Skeleton Loading Row -->
<tr class="bg-white dark:bg-slate-900">
<td class="px-6 py-4">
<div class="h-4 w-16 skeleton rounded"></div>
</td>
<td class="px-6 py-4">
<div class="flex items-center gap-3">
<div class="size-8 skeleton rounded-full"></div>
<div class="h-4 w-24 skeleton rounded"></div>
</div>
</td>
<td class="px-6 py-4">
<div class="h-6 w-16 skeleton rounded"></div>
</td>
<td class="px-6 py-4">
<div class="h-4 w-20 skeleton rounded"></div>
</td>
<td class="px-6 py-4">
<div class="h-4 w-20 skeleton rounded"></div>
</td>
<td class="px-6 py-4">
<div class="h-6 w-20 skeleton rounded-full"></div>
</td>
<td class="px-6 py-4 text-right">
<div class="flex justify-end gap-2">
<div class="h-8 w-12 skeleton rounded"></div>
<div class="h-8 w-12 skeleton rounded"></div>
</div>
</td>
</tr>
<!-- Row 3 -->
<tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors opacity-50">
<td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-slate-400">RES-0998</td>
<td class="px-6 py-4 whitespace-nowrap">
<div class="flex items-center gap-3">
<div class="size-8 rounded-full bg-slate-200 dark:bg-slate-700 overflow-hidden grayscale">
<img alt="Mike Miller" class="size-full" data-alt="Mike Miller profile headshot" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDqvkwlB2j4EXsUIdw1hle2KOZwrqO3q9kkZDf12CyTTDTb5fnCHDES_IrmK3vlHcaFDBMvohGZPd9UbE-NrBSAUoLKzdcjKsospLcvUOMrdP7ZEHe6BQ_-hsYoSdm-_whZz9Zk7Ewd8BcmzjIg6qgCEBoZdFEpMIDThr9r4b_THEjKoCx6bCrsPt_bn6NPjweLXqFGehKMvr9oPsAFbBmPu0XOFlzGsqfjqn5b-Kp-BjM5qVV-B-3wQO1eXmtG6lWz8FkTzWPn2G0w"/>
</div>
<span class="text-sm font-semibold text-slate-500 dark:text-slate-400">Mike Miller</span>
</div>
</td>
<td class="px-6 py-4 whitespace-nowrap">
<span class="px-2.5 py-1 rounded bg-slate-100 dark:bg-slate-800 text-slate-500 text-xs font-bold uppercase">Standard</span>
</td>
<td class="px-6 py-4 whitespace-nowrap text-sm text-slate-400">Oct 20, 2023</td>
<td class="px-6 py-4 whitespace-nowrap text-sm text-slate-400">Oct 21, 2023</td>
<td class="px-6 py-4 whitespace-nowrap">
<span class="flex items-center gap-1.5 text-slate-500 text-xs font-bold px-2 py-1 rounded-full bg-slate-100 dark:bg-slate-800 w-fit">
<span class="size-1.5 rounded-full bg-slate-400"></span>
                                    Cancelled
                                </span>
</td>
<td class="px-6 py-4 whitespace-nowrap text-right space-x-2">
<button class="inline-flex items-center px-3 py-1.5 bg-primary text-white text-xs font-bold rounded hover:bg-primary/90 transition-all">
                                    View
                                </button>
<button class="inline-flex items-center px-3 py-1.5 bg-slate-200 text-slate-400 text-xs font-bold rounded cursor-not-allowed" disabled="">
                                    Cancel
                                </button>
</td>
</tr>
</tbody>
</table>
</div>
<!-- Pagination -->
<div class="px-6 py-4 border-t border-slate-200 dark:border-slate-800 bg-slate-50/50 dark:bg-slate-800/30 flex items-center justify-between">
<div class="text-sm text-slate-500">
                    Showing <span class="font-bold text-slate-700 dark:text-slate-200">1</span> to <span class="font-bold text-slate-700 dark:text-slate-200">10</span> of <span class="font-bold text-slate-700 dark:text-slate-200">42</span> reservations
                </div>
<div class="flex gap-2">
<button class="p-2 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-white dark:hover:bg-slate-800 text-slate-500 transition-all disabled:opacity-50" disabled="">
<span class="material-symbols-outlined text-sm">chevron_left</span>
</button>
<button class="px-3.5 py-1.5 bg-primary text-white rounded-lg text-sm font-bold shadow-sm shadow-primary/20">1</button>
<button class="px-3.5 py-1.5 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-200 rounded-lg text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-700 transition-all">2</button>
<button class="px-3.5 py-1.5 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-200 rounded-lg text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-700 transition-all">3</button>
<button class="p-2 border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-white dark:hover:bg-slate-800 text-slate-500 transition-all">
<span class="material-symbols-outlined text-sm">chevron_right</span>
</button>
</div>
</div>
</div>
<!-- Float Action Button (Mobile only conceptually, but clean for desktop too) -->
<div class="fixed bottom-8 right-8">
<button class="flex items-center gap-2 bg-primary text-white px-6 py-4 rounded-full shadow-2xl hover:scale-105 transition-transform font-bold">
<span class="material-symbols-outlined">add</span>
<span>New Reservation</span>
</button>
</div>
</main>
</body></html>