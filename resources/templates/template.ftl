<#-- @ftlvariable name="user" type="model.User" -->

<#macro mainLayout title="Welcome">
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Bro?</title>
        <link rel="stylesheet" href="/styles/main.css" />
    </head>
    <body>
    <nav>
        <div class="nav-left">
            <img src="./icontitle.png" alt="Logo">
        </div>

        <div class="nav-middle">
            <a href="/" class="active">Homepage</a>
        </div>

        <div class="nav-right">
            <#if user??>
                <a href="/post-new"><button>New Post</button></a>
                <img class="profile" src="./icon.png">
            <#else>
                <a href="/login"><button class="login">Log in</button></a>
                <a href="/register"><button class="register">Register</button></a>
            </#if>
        </div>
    </nav>

    <#nested />

    </div>
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