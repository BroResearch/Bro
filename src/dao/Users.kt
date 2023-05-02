package dao

import org.jetbrains.exposed.sql.*

/**
 * Represents the Users table using Exposed as DAO.
 */
object Users : Table() {
    val id = varchar("id", 20)
    val email = varchar("email", 128).uniqueIndex()
    val displayName = varchar("display_name", 256)
    val profilePic = varchar("profile_picture", 1024)
    val passwordHash = varchar("password_hash", 64)
    val isAdmin = bool("is_admin").default(false) // new column
}
