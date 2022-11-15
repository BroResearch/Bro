package com.bro.models

import java.util.concurrent.atomic.AtomicInteger

class Article (
    val id: Int = idCounter.getAndIncrement(),
    var title: String,
    var body: String
){
    companion object {
        private val idCounter = AtomicInteger()
    }
}

val articles = mutableListOf(Article(
    title = "The drive to develop!",
    body = "...it's what keeps me going."
))