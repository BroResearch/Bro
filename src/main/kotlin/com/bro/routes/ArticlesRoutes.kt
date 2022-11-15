package com.bro.routes

import com.bro.models.Article
import com.bro.models.articles
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.util.*

fun Route.articleRouting() {
    get("/") {
        call.respondRedirect("articles")
    }
    route("articles") {
        get {
            call.respond(FreeMarkerContent("index.ftl", mapOf("articles" to articles)))
        }
        get("new") {
            call.respond(FreeMarkerContent("new.ftl", model = null))
        }
        post {
            val formParameters = call.receiveParameters()
            val title = formParameters.getOrFail("title")
            val body = formParameters.getOrFail("body")
            val newEntry = Article(title = title,body =  body)
            articles.add(newEntry)
            call.respondRedirect("/articles/${newEntry.id}")
        }
        get("{id}") {
            val id = call.parameters.getOrFail<Int>("id").toInt()
            call.respond(FreeMarkerContent("show.ftl", mapOf("article" to articles.find { it.id == id })))
        }
        get("{id}/edit") {
            val id = call.parameters.getOrFail<Int>("id").toInt()
            call.respond(FreeMarkerContent("edit.ftl", mapOf("article" to articles.find { it.id == id })))
        }
        post("{id}") {
            val id = call.parameters.getOrFail<Int>("id").toInt()
            val formParameters = call.receiveParameters()
            when (formParameters.getOrFail("_action")) {
                "update" -> {
                    val index = articles.indexOf(articles.find { it.id == id })
                    val title = formParameters.getOrFail("title")
                    val body = formParameters.getOrFail("body")
                    articles[index].title = title
                    articles[index].body = body
                    call.respondRedirect("/articles/$id")
                }
                "delete" -> {
                    articles.removeIf { it.id == id }
                    call.respondRedirect("/articles")
                }
            }
        }
    }
}