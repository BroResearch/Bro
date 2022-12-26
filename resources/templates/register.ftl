<#-- @ftlvariable name="error" type="java.lang.String" -->
<#-- @ftlvariable name="pageUser" type="model.User" -->

<#import "template.ftl" as layout />

<@layout.mainLayout title="Welcome">
    <div class="bro">
        <form action="/register" method="post" enctype="multipart/form-data">
            <ul>
                <li>
                    <label for="userId">Username:</label>
                    <input type="text" id="userId" name="userId" value="${pageUser.userId}">
                </li>
                <li>
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="${pageUser.email}">
                </li>
                <li>
                    <label for="displayName">Display name:</label>
                    <input type="text" id="displayName" name="displayName" value="${pageUser.displayName}">
                </li>
                <li>
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password">
                </li>
            </ul>
            <input type="submit" value="Register">
        </form>
        <#if error??>
            <p class="alert">${error}</p>
        </#if>
    </div>
</@layout.mainLayout>

