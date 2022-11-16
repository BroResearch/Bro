package com.bro

import com.bro.dao.DatabaseFactory
import io.ktor.server.application.*
import com.bro.plugins.*

fun main(args: Array<String>): Unit =
    io.ktor.server.netty.EngineMain.main(args)

fun Application.module() {
    DatabaseFactory.init()
    configureTemplating()
    configureRouting()
    configureSockets()
}
