package com.bro.plugins

import com.bro.routes.articleRouting
import io.ktor.server.routing.*
import io.ktor.server.http.content.*
import io.ktor.server.application.*

fun Application.configureRouting() {
    routing {
        static("/static") {
            resources("static")
        }
        articleRouting()
    }
}
