<#-- @ftlvariable name="error" type="java.lang.String" -->
<#-- @ftlvariable name="userId" type="java.lang.String" -->

<#import "template.ftl" as layout />

<@layout.mainLayout title="Welcome">
    <div class="bro">
        <form action="/login" method="post" enctype="application/x-www-form-urlencoded">
            <ul>
                <li>
                    <label for="userId">Username:</label>
                    <input type="text" id="userId" name="userId" value="${userId}">
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