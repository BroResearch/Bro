<#-- @ftlvariable name="posts" type="java.util.List<kotlin.Pair<model.Post,java.lang.String>>" -->

<#import "template.ftl" as layout />

<@layout.mainLayout title="Homepage">
    <@layout.posts_list posts=posts></@layout.posts_list>
</@layout.mainLayout>
