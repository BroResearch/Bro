package model

import java.io.*

data class User(val userId: String, val email: String, val displayName: String, val passwordHash: String) : Serializable