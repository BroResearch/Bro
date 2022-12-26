<#-- @ftlvariable name="pageUser" type="model.User" -->
<#-- @ftlvariable name="posts" type="java.util.List<model.Post>" -->

<#import "template.ftl" as layout />

<@layout.mainLayout title="User ${pageUser.displayName}">
<h3>User's posts</h3>

<@layout.posts_list posts=posts></@layout.posts_list>
</@layout.mainLayout>
