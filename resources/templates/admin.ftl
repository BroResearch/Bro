<#-- @ftlvariable name="users" type="java.util.List<model.User>" -->

<#import "template.ftl" as layout />
<@layout.mainLayout title="Admin">
    <h1>Admin Panel</h1>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Email</th>
            <th>Display Name</th>
            <th>Profile Picture</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <form action="/admin" method="POST">
                <td>${user.userId}</td>
                <td>${user.email}</td>
                <td>${user.displayName}</td>
                <td><img src="uploads/${user.profilePic}"></td>
                <td>
                    <input type="hidden" name="userId" value="${user.userId}">
                    <button type="submit">Delete</button>
                </td>
                </form>
            </tr>
        </#list>
        </tbody>
    </table>
</@layout.mainLayout>