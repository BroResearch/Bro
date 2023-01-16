<#import "template.ftl" as layout />

<@layout.mainLayout title="Edit User">
    <div class="w-full px-4 py-6 mx-auto max-w-7xl md:w-4/5">
    <div class="overflow-hidden rounded bg-background shadow sm:rounded-lg">
        <form action="/user/${user.userId}/edit" method="post" enctype="multipart/form-data">
            <input type="hidden" name="date" value="${date?c}">
            <input type="hidden" name="code" value="${code}">
            <div class="flex">
                <div class="px-4 py-5 sm:px-6">
                    <h3 class="text-lg font-medium leading-6 text-foreground">${user.userId} info</h3>
                    <p class="mt-1 max-w-2xl text-sm text-purple">Edit personal details</p>
                </div>
                <label>
                    <button value="Post" type="submit"></button>
                    <svg class="w-8 h-8 ml-auto mr-4 mt-4 text-foreground hover:bg-purple rounded-full" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" >
                        <path stroke-linecap="round" stroke-linejoin="round" d="M4.5 12.75l6 6 9-13.5" />
                    </svg>
                </label>

            </div>
            <div class="border-t border-purple">
                <dl>
                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-purple">Display Name</dt>
                        <dd class="mt-1 text-sm text-background sm:col-span-2 sm:mt-0">
                            <input  type="text" name="display-name" id="display-name" autocomplete="given-name" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required>
                        </dd>
                    </div>
                    <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-purple">Email address</dt>
                        <dd class="mt-1 text-sm text-background sm:col-span-2 sm:mt-0">
                            <input type="text" name="email" id="email" autocomplete="given-name" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" required>
                        </dd>
                    </div>
                    <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                        <dt class="text-sm font-medium text-purple">Profile photo</dt>
                        <dd class="mt-1 text-sm flex items-center text-foreground sm:col-span-2 sm:mt-0">
                      <span class="inline-block h-12 w-12 overflow-hidden rounded-full bg-currentLine">
                        <img class="h-full w-full rounded-full"
                             src="/uploads/${user.profilePic}"
                             alt="" />
                      </span>
                            <input  id="file_input" type="file" class="ml-5 rounded-md border py-2 px-3 text-sm font-medium leading-4 text-gray-700 shadow-sm hover:bg-purple focus:outline-none focus:ring-2 focus:ring-pink focus:ring-offset-2" required></input>
                        </dd>
                    </div>
                </dl>
            </div>
        </form>
    </div>
    </div>

</@layout.mainLayout>