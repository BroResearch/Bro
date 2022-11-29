package com.bro.routes

import com.bro.dao.DAOarticle
import com.bro.dao.impl.DAOarticleImpl
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.util.*

val dao: DAOarticle = DAOarticleImpl()

fun Route.articleRouting() {
    get("/") {
        call.respondRedirect("articles")
    }
    route("articles") {
        get {
            call.respond(FreeMarkerContent("index.ftl", mapOf("articles" to dao.allArticles())))
        }
        get("new") {
            call.respond(FreeMarkerContent("new.ftl", model = null))
        }
        post {
            var title: String = ""
            var body: String = ""
            var image: ByteArray = byteArrayOf()

            val multipartData = call.receiveMultipart()

            multipartData.forEachPart { part ->
                when (part) {
                    is PartData.FormItem -> {
                        when(part.name){
                            "title" -> title = part.value
                            "body" -> body = part.value
                        }
                    }

                    is PartData.FileItem -> {
                        val fileBytes = part.streamProvider().readBytes()
                        image = fileBytes
                    }

                    else -> {}
                }
                part.dispose()
            }

            val article = dao.addNewArticle(title, body, image)
            call.respondRedirect("/articles/${article?.id}")
        }
        get("{id}") {
            val id = call.parameters.getOrFail<Int>("id").toInt()
            call.respond(FreeMarkerContent("show.ftl", mapOf("article" to dao.article(id))))
        }
        get("{id}/edit") {
            val id = call.parameters.getOrFail<Int>("id").toInt()
            call.respond(FreeMarkerContent("edit.ftl", mapOf("article" to dao.article(id))))
        }
        post("{id}") {
            val id = call.parameters.getOrFail<Int>("id").toInt()
            val formParameters = call.receiveParameters()
            when (formParameters.getOrFail("_action")) {
                "update" -> {
                    val title = formParameters.getOrFail("title")
                    val body = formParameters.getOrFail("body")
                    dao.editArticle(id, title, body)
                    call.respondRedirect("/articles/$id")
                }
                "delete" -> {
                    dao.deleteArticle(id)
                    call.respondRedirect("/articles")
                }
            }
        }
    }
}