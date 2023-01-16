package model

import kotlinx.serialization.Serializable

@Serializable
data class User(
    val userId: String,
    val email: String,
    val displayName: String,
    val profilePic: String,
    val passwordHash: String
) : java.io.Serializable