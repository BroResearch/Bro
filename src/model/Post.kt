package model

import org.joda.time.*
import java.io.*

data class Post(
    val id: Int,
    val userId: String,
    val date: DateTime,
    val title: String,
    val text: String,
    val image: String
) : Serializable
