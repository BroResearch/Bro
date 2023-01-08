<#-- @ftlvariable name="user" type="model.User" -->

<#macro mainLayout title="Welcome">
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${title} | Bro?</title>
        <link rel="shortcut icon" href="/uploads/favicon.ico" type="image/x-icon">
        <link rel="stylesheet" href="/styles/main.css" />
    </head>

    <body class="bg-currentLine">
    <nav x-data="{ isClosed: false }" class="bg-background">
        <div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
            <div class="relative flex h-16 items-center justify-between">
                <div class="absolute inset-y-0 left-0 flex items-center sm:hidden">
                    <!-- Mobile menu button-->
                    <button @click="isClosed = !isClosed" type="button"
                            class="inline-flex items-center justify-center rounded-md p-2 text-foreground hover:bg-currentLine hover:text-purple "
                            aria-controls="mobile-menu" aria-expanded="false">
                        <span class="sr-only">Open main menu</span>
                        <!--
                              Icon when menu is closed.

                              Heroicon name: outline/bars-3

                              Menu open: "hidden", Menu closed: "block"
                            -->
                        <svg :class="{'hidden': isClosed, 'block': !isClosed }" class="block h-6 w-6"
                             xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                             stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
                        </svg>
                        <!--
                              Icon when menu is open.

                              Heroicon name: outline/x-mark

                              Menu open: "block", Menu closed: "hidden"
                            -->
                        <svg :class="{'block': isClosed, 'hidden': !isClosed }" class="hidden h-6 w-6"
                             xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                             stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
                <div class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">
                    <div class="flex flex-shrink-0 items-center">
                        <img class="block h-8 w-auto lg:hidden" src="/uploads/title.png" alt="Bro?">
                        <img class="hidden h-8 w-auto lg:block" src="/uploads/title.png" alt="Bro?">
                    </div>
                    <div class="hidden sm:ml-6 sm:block">
                        <div class="flex space-x-4">
                            <a href="/"
                               class="text-foreground hover:bg-currentLine hover:text-purple px-3 py-2 rounded-md text-sm font-medium">Homepage</a>

                            <a href="#"
                               class="text-foreground hover:bg-currentLine hover:text-purple px-3 py-2 rounded-md text-sm font-medium">Team</a>

                            <a href="#"
                               class="text-foreground hover:bg-currentLine hover:text-purple px-3 py-2 rounded-md text-sm font-medium">API
                                docs</a>
                        </div>
                    </div>
                </div>
                <#if user??>
                <div class="absolute inset-y-0 right-0 flex items-center pr-2 sm:static sm:inset-auto sm:ml-6 sm:pr-0">
                    <form action="/post-new">
                        <button type="submit" class="rounded-full hover:bg-currentLine p-1 text-foreground hover:text-purple">
                            <span class="sr-only">New post</span>
                            <!-- Heroicon name: outline/plus-circle -->
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                                 stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v6m3-3H9m12 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                            </svg>
                        </button>
                    </form>

                    <!-- Profile dropdown -->
                    <div x-data="{ isOpen: false }" class="relative ml-3">
                        <div>
                            <button @click="isOpen = !isOpen" type="button"
                                    class="flex rounded-full bg-green text-sm focus:outline-none focus:ring-2 focus:ring-purple "
                                    id="user-menu-button" aria-expanded="false" aria-haspopup="true">
                                <span class="sr-only">Open user menu</span>
                                <img class="h-8 w-8 rounded-full"
                                     src="uploads/${user.userId}"
                                     alt="" />
                            </button>
                        </div>

                        <!--
                              Dropdown menu, show/hide based on menu state.

                              Entering: "transition ease-out duration-100"
                                From: "transform opacity-0 scale-95"
                                To: "transform opacity-100 scale-100"
                              Leaving: "transition ease-in duration-75"
                                From: "transform opacity-100 scale-100"
                                To: "transform opacity-0 scale-95"
                            -->
                        <div x-show="isOpen" x-transition:enter="transition ease-out duration-100 transform"
                             x-transition:enter-start="opacity-0 scale-95" x-transition:enter-end="opacity-100 scale-100"
                             x-transition:leave="transition ease-in duration-75 transform"
                             x-transition:leave-start="opacity-100 scale-100" x-transition:leave-end="opacity-0 scale-95"
                             class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-currentLine py-1 shadow-lg"
                             role="menu" aria-orientation="vertical" aria-labelledby="user-menu-button" tabindex="-1">
                            <!-- Active: "bg-gray-100", Not Active: "" -->
                            <a href="/user/${user.userId}" class="block px-4 py-2 text-sm text-foreground hover:text-purple" role="menuitem"
                               tabindex="-1" id="user-menu-item-0">Your Profile</a>
                            <a href="#" class="block px-4 py-2 text-sm text-foreground hover:text-purple" role="menuitem"
                               tabindex="-1" id="user-menu-item-1">Settings</a>
                            <a href="/logout" class="block px-4 py-2 text-sm text-foreground hover:text-purple" role="menuitem"
                               tabindex="-1" id="user-menu-item-2">Sign out</a>
                        </div>
                    </div>
                </div>
                <#else>
                    <div class="hidden items-center justify-end sm:flex sm:flex-1 lg:w-0">
                        <a href="/login" class="whitespace-nowrap text-base font-medium text-foreground hover:text-purple hover:underline">Sign in</a>
                        <a href="/register" class="ml-8 inline-flex items-center justify-center whitespace-nowrap rounded-md border border-transparent bg-green px-4 py-2 text-base font-medium text-background shadow-sm hover:text-currentLine">Sign up</a>
                    </div>
                </#if>
            </div>
        </div>

        <!-- Mobile menu, show/hide based on menu state. -->
    <#if user??>
        <div x-show="isClosed" x-transition:enter="transition ease-out duration-100 transform"
             x-transition:enter-start="opacity-0 scale-95" x-transition:enter-end="opacity-100 scale-100"
             x-transition:leave="transition ease-in duration-75 transform" x-transition:leave-start="opacity-100 scale-100"
             x-transition:leave-end="opacity-0 scale-95" class="sm:hidden" id="mobile-menu">
            <div class="space-y-1 px-2 pt-2 pb-3">
                <a href="/"
                   class="text-foreground hover:bg-currentLine hover:text-purple block px-3 py-2 rounded-md text-base font-medium">Homepage</a>

                <a href="#"
                   class="text-foreground hover:bg-currentLine hover:text-purple block px-3 py-2 rounded-md text-base font-medium">Team</a>

                <a href="#"
                   class="text-foreground hover:bg-currentLine hover:text-purple block px-3 py-2 rounded-md text-base font-medium">API
                    docs</a>
            </div>
        </div>
    <#else>
        <div x-show="isClosed" x-transition:enter="transition ease-out duration-100 transform"
             x-transition:enter-start="opacity-0 scale-95" x-transition:enter-end="opacity-100 scale-100"
             x-transition:leave="transition ease-in duration-75 transform" x-transition:leave-start="opacity-100 scale-100"
             x-transition:leave-end="opacity-0 scale-95" class="sm:hidden" id="mobile-menu">
            <div class="space-y-1 px-2 pt-2 pb-3">
                <a href="/"
                   class="text-foreground hover:bg-currentLine hover:text-purple block px-3 py-2 rounded-md text-base font-medium">Homepage</a>

                <a href="#"
                   class="text-foreground hover:bg-currentLine hover:text-purple block px-3 py-2 rounded-md text-base font-medium">Team</a>

                <a href="#"
                   class="text-foreground hover:bg-currentLine hover:text-purple block px-3 py-2 rounded-md text-base font-medium">API
                    docs</a>
            </div>
            <div class="space-y-1 px-2 pt-2 pb-3">
                <a href="/register" class="flex w-full items-center justify-center rounded-md border border-transparent px-4 py-2 text-base font-medium text-background shadow-sm hover:text-currentLine bg-green">Sign up</a>
                <p class="mt-6 text-center text-base font-medium text-foreground">
                    Existing user?
                    <a href="/login" class="text-purple">Sign in</a>
                </p>
            </div>
        </div>
    </#if>

    </nav>

    <header class="bg-currentLine shadow">
        <div class="mx-auto max-w-7xl py-6 px-4 sm:px-6 lg:px-8">
            <h1 class="text-3xl font-bold tracking-tight text-pink align">${title}</h1>
        </div>
    </header>
    <main>
        <div class="mx-auto max-w-7xl py-6 sm:px-6 lg:px-8">
            <!-- Replace with your content -->
            <#nested />
            <!-- /End replace -->
        </div>
    </main>
    <script src="/scripts/main.js"></script>
    </body>

    </html>
</#macro>

<#macro post_li post>
<#-- @ftlvariable name="post" type="model.Post" -->
    <div class="bro">
        <p class="text">${post.text}</p>
        <img src="/uploads/${post.image}" alt="${post.id} img">
        <p class="author">
            <a href="/post/${post.id}">${post.date.toDate()?string("yyyy.MM.dd HH:mm:ss")}</a>
            by <a href="/user/${post.userId}">${post.userId}</a></p>
    </div>
</#macro>

<#macro posts_list posts>
<ul>
    <#list posts as post>
        <@post_li post=post></@post_li>
    <#else>
        <li>There are no posts yet</li>
    </#list>
</ul>
</#macro>