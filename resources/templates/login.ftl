<#-- @ftlvariable name="error" type="java.lang.String" -->
<#-- @ftlvariable name="userId" type="java.lang.String" -->

<#import "template.ftl" as layout />

<@layout.mainLayout title="Login">
    <#if error??>
        <div x-data="{ isClosed: false }" :class="{'hidden': isClosed, '': !isClosed }" class="bg-red rounded">
            <div class="mx-auto max-w-7xl py-3 px-3 sm:px-6 lg:px-8">
                <div class="flex flex-wrap items-center justify-between">
                    <div class="flex w-0 flex-1 items-center">
                      <span class="flex rounded-lg bg-orange p-2">
                        <!-- Heroicon name: outline/exclamation-circle -->
                            <svg class="h-6 w-6 text-background" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m9-.75a9 9 0 11-18 0 9 9 0 0118 0zm-9 3.75h.008v.008H12v-.008z" />
                            </svg>
                      </span>
                        <p class="ml-3 truncate font-medium text-background">
                            <span class="md:hidden">${error}</span>
                            <span class="hidden md:inline">${error}</span>
                        </p>
                    </div>
                    <div class="order-2 flex-shrink-0 sm:order-3 sm:ml-3">
                        <button @click="isClosed = !isClosed" type="button" class="-mr-1 flex rounded-md p-2 hover:bg-orange focus:outline-none focus:ring-2 focus:ring-background sm:-mr-2">
                            <span class="sr-only">Dismiss</span>
                            <!-- Heroicon name: outline/x-mark -->
                            <svg class="h-6 w-6 text-background" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </#if>
<div class="flex min-h-full items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="w-full max-w-md space-y-8">
            <div>
                <img class="mx-auto h-20 w-auto" src="/uploads/icontitle.png" alt="Bro?">
                <h2 class="mt-6 text-center text-3xl font-bold tracking-tight underline decoration-purple text-foreground">Sign in to your account</h2>
            </div>
            <form class="mt-8 space-y-6" action="/login" method="POST" enctype="application/x-www-form-urlencoded">
                <input type="hidden" name="remember" value="true">
                <div class="-space-y-px rounded-md shadow-sm">
                    <div>
                        <label for="userId" class="sr-only">Username</label>
                        <input value="${userId}" id="userId" name="userId" type="text" required class="relative block w-full appearance-none rounded-none rounded-t-md border border-gray-300 px-3 py-2 text-gray-900 placeholder-gray-500 focus:z-10 focus:outline-none focus:border-purple focus:ring-purple sm:text-sm" placeholder="Username">
                    </div>
                    <div>
                        <label for="password" class="sr-only">Password</label>
                        <input id="password" name="password" type="password" autocomplete="current-password" required class="relative block w-full appearance-none rounded-none rounded-b-md border border-gray-300 px-3 py-2 text-gray-900 placeholder-gray-500 focus:z-10 focus:outline-none focus:border-purple focus:ring-purple sm:text-sm" placeholder="Password">
                    </div>
                </div>

                <div class="flex items-center justify-between">
                    <div class="flex items-center">
                        <input id="remember-me" name="remember-me" type="checkbox" class="h-4 w-4 rounded border-gray-300 text-purple focus:ring-pink">
                        <label for="remember-me" class="ml-2 block text-sm text-foreground">Remember me</label>
                    </div>

                    <div class="text-sm">
                        <a href="#" class="font-medium text-pink hover:text-purple">Forgot your password?</a>
                    </div>
                </div>

                <div>
                    <button value="Login" type="submit" class="group relative flex w-full justify-center rounded-md border border-transparent bg-purple py-2 px-4 text-sm font-medium text-foreground hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">
                        Sign in
                    </button>
                </div>
            </form>
        </div>
    </div>

</@layout.mainLayout>