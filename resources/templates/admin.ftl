<#-- @ftlvariable name="users" type="java.util.List<model.User>" -->

<#import "template.ftl" as layout />
<@layout.mainLayout title="Admin">
    <div class="md:grid md:gap-6">
        <div class="mt-5 md:mt-0">
            <div class="bg-background shadow-2xl sm:overflow-hidden sm:rounded-md text-foreground">
                <h1 class="text-3xl font-bold text-pink mt-5 mb-5 ml-5">Admin Panel</h1>
                <div class="overflow-x-auto m-5">
                    <table class="table-auto w-full">
                        <thead class="text-left text-purple">
                        <tr>
                            <th class="px-4 py-2">ID</th>
                            <th class="px-4 py-2">Email</th>
                            <th class="px-4 py-2">Display Name</th>
                            <th class="px-4 py-2">Profile Picture</th>
                            <th class="px-4 py-2">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list users as user>
                        <tr class="divide-y">
                            <form action="/admin" method="POST">
                                <td class="px-4 py-2">${user.userId}</td>
                                <td class="px-4 py-2">${user.email}</td>
                                <td class="px-4 py-2">${user.displayName}</td>
                                <td class="px-4 py-2">
                                    <div class="flex justify-center">
                                        <img src="uploads/${user.profilePic}">
                                    </div>
                                </td>
                                <td class="px-4 py-2 text-center">
                                    <input type="hidden" name="userId" value="${user.userId}">
                                    <button type="submit" class="text-white font-bold py-2 px-4 rounded bg-red hover:bg-pink">Delete</button>
                                </td>
                            </form>
                        </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</@layout.mainLayout>