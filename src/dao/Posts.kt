package dao

import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.jodatime.*

/**
 * Represents the Posts table using Exposed as DAO.
 */
object Posts : Table() {
    val id = integer("id").autoIncrement()
    val user = varchar("user_id", 20).index()
    val date = datetime("date")
    val text = varchar("text", 1024)
    val image = varchar("image", 1024)
}
