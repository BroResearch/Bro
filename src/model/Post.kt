package model

import org.joda.time.*
import kotlinx.serialization.Serializable
import plugin.DateAsLongSerializer

@Serializable
data class Post(
    val id: Int,
    val userId: String,
    @Serializable(with = DateAsLongSerializer::class)
    val date: DateTime,
    val title: String,
    val text: String,
    val image: String
) : java.io.Serializable
