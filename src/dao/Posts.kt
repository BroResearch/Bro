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
    val title = varchar("title",1024)
    val text = varchar("text", 4096)
    val image = varchar("image", 1024)
}
