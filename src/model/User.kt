package model

import java.io.*

data class User(
    val userId: String,
    val email: String,
    val displayName: String,
    val profilePic: String,
    val passwordHash: String
) : Serializable