package com.bro

import io.ktor.server.application.*
import com.bro.plugins.*

fun main(args: Array<String>): Unit =
    io.ktor.server.netty.EngineMain.main(args)

fun Application.module() {
    configureTemplating()
    configureRouting()
}
