<#-- @ftlvariable name="date" type="java.lang.Long" -->
<#-- @ftlvariable name="code" type="java.lang.String" -->
<#-- @ftlvariable name="post" type="model.Post" -->
<#import "template.ftl" as layout />

<@layout.mainLayout title="New post">
    <article>
        <header class="flex flex-col">
            <a class="flex items-center" href="/post/${post.id}" >
                <div class="inline-block h-12 w-12 rounded-full ring-2s ring-cyan">
                    <img src="/uploads/${post.userId}" alt="Photo of ${post.userId}" />
                </div>
                <div class="ml-2">
                    <p class="text-sm font-semibold text-foreground hover:text-cyan">${post.userId}</p>
                    <p class="text-sm text-cyan">${post.date.toDate()?string("yyyy.MM.dd HH:mm:ss")}</p>
                </div>
            </a>
            <h1 class="mt-6 text-4xl font-bold tracking-tight underline decoration-purple text-foreground sm:text-5xl">
                ${post.id}</h1>
        </header>
        <div class="mt-8 prose text-foreground">
            <p class="pb-10 text-lg">${post.text}</p>
            <img class="mx-auto rounded" alt="" src="/uploads/${post.image}">
        </div>
        <#if user??>
        <button onclick="document.getElementById('deleteForm').submit()" type="button" class="px-6 py-2.5 mt-4 bg-red text-foreground font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-pink hover:shadow-lg focus:bg-pink focus:shadow-lg focus:outline-none focus:ring-0">Delete post</button>
        <form id="deleteForm" method="post" action="/post/${post.id}/delete" enctype="application/x-www-form-urlencoded">
            <input type="hidden" name="date" value="${date?c}">
            <input type="hidden" name="code" value="${code}">
        </form>
        </#if>
    </article>
</@layout.mainLayout>