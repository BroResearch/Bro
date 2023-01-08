<#-- @ftlvariable name="posts" type="java.util.List<model.Post>" -->

<#import "template.ftl" as layout />

<@layout.mainLayout title="Homepage">
    <@layout.posts_list posts=posts></@layout.posts_list>
</@layout.mainLayout>
