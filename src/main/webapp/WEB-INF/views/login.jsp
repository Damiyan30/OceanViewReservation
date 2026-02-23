<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>HotelSys Login Page</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
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
<body class="bg-background-light dark:bg-background-dark min-h-screen flex items-center justify-center p-4">
<div class="w-full max-w-[440px] bg-white dark:bg-slate-900 shadow-xl rounded-xl overflow-hidden border border-slate-200 dark:border-slate-800">
<div class="px-8 pt-10 pb-6 text-center">
<div class="flex justify-center mb-4">
<div class="bg-primary/10 p-3 rounded-xl">
<svg class="w-10 h-10 text-primary" fill="none" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg">
<path clip-rule="evenodd" d="M39.475 21.6262C40.358 21.4363 40.6863 21.5589 40.7581 21.5934C40.7876 21.655 40.8547 21.857 40.8082 22.3336C40.7408 23.0255 40.4502 24.0046 39.8572 25.2301C38.6799 27.6631 36.5085 30.6631 33.5858 33.5858C30.6631 36.5085 27.6632 38.6799 25.2301 39.8572C24.0046 40.4502 23.0255 40.7407 22.3336 40.8082C21.8571 40.8547 21.6551 40.7875 21.5934 40.7581C21.5589 40.6863 21.4363 40.358 21.6262 39.475C21.8562 38.4054 22.4689 36.9657 23.5038 35.2817C24.7575 33.2417 26.5497 30.9744 28.7621 28.762C30.9744 26.5497 33.2417 24.7574 35.2817 23.5037C36.9657 22.4689 38.4054 21.8562 39.475 21.6262ZM4.41189 29.2403L18.7597 43.5881C19.8813 44.7097 21.4027 44.9179 22.7217 44.7893C24.0585 44.659 25.5148 44.1631 26.9723 43.4579C29.9052 42.0387 33.2618 39.5667 36.4142 36.4142C39.5667 33.2618 42.0387 29.9052 43.4579 26.9723C44.1631 25.5148 44.659 24.0585 44.7893 22.7217C44.9179 21.4027 44.7097 19.8813 43.5881 18.7597L29.2403 4.41187C27.8527 3.02428 25.8765 3.02573 24.2861 3.36776C22.6081 3.72863 20.7334 4.58419 18.8396 5.74801C16.4978 7.18716 13.9881 9.18353 11.5858 11.5858C9.18354 13.988 7.18717 16.4978 5.74802 18.8396C4.58421 20.7334 3.72865 22.6081 3.36778 24.2861C3.02574 25.8765 3.02429 27.8527 4.41189 29.2403Z" fill="currentColor" fill-rule="evenodd"></path>
</svg>
</div>
</div>
<h1 class="text-slate-900 dark:text-slate-100 text-3xl font-bold tracking-tight mb-1">HotelSys</h1>
<p class="text-slate-500 dark:text-slate-400 text-sm font-medium">Ocean View Resort Management</p>
</div>
<div class="px-8 pb-10">
<div class="mb-6 p-3 rounded-lg bg-red-50 border border-red-100 flex items-start gap-3">
<span class="material-symbols-outlined text-red-600 text-[20px] mt-0.5">error</span>
<p class="text-red-700 text-sm leading-snug">
                    The username or password you entered is incorrect. Please try again.
                </p>
</div>
<form action="#" class="space-y-5" method="POST">
<div class="space-y-1.5">
<div class="flex justify-between items-center">
<label class="text-slate-700 dark:text-slate-300 text-sm font-semibold" for="username">Username</label>
<span class="text-slate-400 dark:text-slate-500 text-[11px] uppercase tracking-wider font-bold">* Required</span>
</div>
<div class="relative group">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 group-focus-within:text-primary transition-colors">person</span>
<input class="w-full pl-10 pr-4 h-12 rounded-lg border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-slate-100 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all text-base" id="username" name="username" placeholder="Enter your username" type="text"/>
</div>
</div>
<div class="space-y-1.5">
<div class="flex justify-between items-center">
<label class="text-slate-700 dark:text-slate-300 text-sm font-semibold" for="password">Password</label>
<span class="text-slate-400 dark:text-slate-500 text-[11px] uppercase tracking-wider font-bold">* Required</span>
</div>
<div class="relative group">
<span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 group-focus-within:text-primary transition-colors">lock</span>
<input class="w-full pl-10 pr-4 h-12 rounded-lg border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-900 dark:text-slate-100 placeholder:text-slate-400 focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all text-base" id="password" name="password" placeholder="••••••••" type="password"/>
</div>
</div>
<div class="flex items-center justify-between pt-1">
<label class="flex items-center gap-2 cursor-pointer group">
<input class="w-4 h-4 rounded border-slate-300 text-primary focus:ring-primary/20 transition-all" type="checkbox"/>
<span class="text-slate-600 dark:text-slate-400 text-sm group-hover:text-slate-900 dark:group-hover:text-slate-200 transition-colors">Remember me</span>
</label>
<a class="text-sm font-semibold text-primary hover:text-primary/80 transition-colors" href="#">Forgot password?</a>
</div>
<button class="w-full bg-primary hover:bg-primary/90 active:scale-[0.98] text-white font-bold h-12 rounded-lg transition-all shadow-md shadow-primary/20 flex items-center justify-center gap-2 mt-4" type="submit">
<span>Login</span>
<span class="material-symbols-outlined text-[18px]">login</span>
</button>
<div class="pt-4 text-center">
<p class="text-slate-600 dark:text-slate-400 text-sm">
                        Don't have an account? 
                        <a class="text-primary font-bold hover:underline transition-all" href="#">Sign up</a>
</p>
</div>
</form>
</div>
<div class="px-8 py-6 bg-slate-50 dark:bg-slate-800/50 border-t border-slate-100 dark:border-slate-800 text-center">
<p class="text-slate-500 dark:text-slate-400 text-xs">
                Access restricted to authorized personnel. 
                <br/>Need help? <a class="text-primary font-medium hover:underline" href="#">Contact System Administrator</a>
</p>
</div>
</div>
<div class="fixed top-0 left-0 w-full h-full -z-10 opacity-40 pointer-events-none overflow-hidden">
<div class="absolute top-[-10%] right-[-10%] w-[40%] h-[40%] bg-primary/10 blur-[100px] rounded-full"></div>
<div class="absolute bottom-[-10%] left-[-10%] w-[40%] h-[40%] bg-primary/10 blur-[100px] rounded-full"></div>
</div>

</body></html>