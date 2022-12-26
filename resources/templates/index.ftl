<#-- @ftlvariable name="posts" type="java.util.List<model.Post>" -->

<#import "template.ftl" as layout />

<@layout.mainLayout title="Welcome">
    <@layout.posts_list posts=posts></@layout.posts_list>
</@layout.mainLayout>
