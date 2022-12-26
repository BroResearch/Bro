<#import "template.ftl" as layout />

<@layout.mainLayout title="New post">
<form action="/post-new" method="post" enctype="multipart/form-data">
    <input type="hidden" name="date" value="${date?c}">
    <input type="hidden" name="code" value="${code}">

    <label for="post-text">Text:
        <textarea id="post-text" name="text" rows="30" cols="100"></textarea>
    </label>

    <label for="post-text">Image:
        <input type="file" name="image" accept="image/png, image/jpeg" required>
    </label>

    <input type="submit" value="Post">
</form>
</@layout.mainLayout>