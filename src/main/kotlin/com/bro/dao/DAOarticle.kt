package com.bro.dao

import com.bro.models.Article

interface DAOarticle {
    suspend fun allArticles(): List<Article>
    suspend fun article(id: Int): Article?
    suspend fun addNewArticle(title: String, body: String, image: ByteArray): Article?
    suspend fun editArticle(id: Int, title: String, body: String, image: ByteArray): Boolean
    suspend fun deleteArticle(id: Int): Boolean
}