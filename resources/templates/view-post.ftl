<#-- @ftlvariable name="date" type="java.lang.Long" -->
<#-- @ftlvariable name="code" type="java.lang.String" -->
<#-- @ftlvariable name="post" type="model.Post" -->
<#import "template.ftl" as layout />

<@layout.mainLayout title="New post">
<section class="post">
    <header class="post-header">
        <p class="post-meta">
            <a href="/post/${post.id}">${post.date.toDate()?string("yyyy.MM.dd HH:mm:ss")}</a>
            by <a href="/user/${post.userId}">${post.userId}</a></p>
    </header>
    <div class="post-description">${post.text}</div>
</section>
<#if user??>
<p>
    <a href="javascript:void(0)" onclick="document.getElementById('deleteForm').submit()">Delete post</a>
</p>

<form id="deleteForm" method="post" action="/post/${post.id}/delete" enctype="application/x-www-form-urlencoded">
    <input type="hidden" name="date" value="${date?c}">
    <input type="hidden" name="code" value="${code}">
</form>
</#if>

</@layout.mainLayout>