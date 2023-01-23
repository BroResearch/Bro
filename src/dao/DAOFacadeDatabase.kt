package dao

import model.Post
import model.User
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.SqlExpressionBuilder.eq
import org.jetbrains.exposed.sql.transactions.*
import org.joda.time.*
import java.io.*

/**
 * A DAO Facade interface for the Database. This allows us to provide several implementations.
 *
 * In this case, this is used to provide a Database-based implementation using Exposed,
 * and a cache implementation composing another DAOFacade.
 */
interface DAOFacade : Closeable {
    /**
     * Initializes all the required data.
     */
    fun init()

    /**
     * Creates a Post from a specific [user] name, the [title], the [image], the [text] content,
     * and the [date] that would default to the current time.
     */
    fun createPost(user: String,title: String, text: String, image: String, date: DateTime = DateTime.now()): Int

    /**
     * Deletes a post from its [id].
     */
    fun deletePost(id: Int)

    /**
     * Get the DAO object representation of a post based from its [id].
     */
    fun getPost(id: Int): Post

    /**
     * Obtains a list of integral ids of posts from a specific user identified by its [userId].
     */
    fun userPosts(userId: String): List<Int>

    /**
     * Tries to get a user from its [userId] and optionally its password [hash].
     * If the [hash] is specified, the password [hash] must match, or the function will return null.
     * If no [hash] is specified, it will return the [User] if exists, or null otherwise.
     */
    fun user(userId: String, hash: String? = null): User?

    /**
     * Tries to get a user from its [email].
     *
     * Returns null if no user has this [email] associated.
     */
    fun userByEmail(email: String): User?

    /**
     * Creates a new [user] in the database from its object [User] representation.
     */
    fun createUser(user: User)

    /**
     * Returns a list of all Posts
     */
    fun allPosts(): List<Post>


    /**
     * Returns a list of all Users
     */
    fun allUsers(): List<User>

    /**
     * Returns a list of Post ids, with the recent ones first.
     */
    fun latest(count: Int = 10): List<Int>

    fun editUser(user: String, email: String, displayName: String, profilePic: String): Boolean
}

/**
 * Database implementation of the facade.
 * Uses Exposed, and either an in-memory H2 database.
 */
class DAOFacadeDatabase(
    private val db: Database = Database.connect("jdbc:h2:mem:test", driver = "org.h2.Driver")
) : DAOFacade {

    override fun init() {
        // Create the used tables
        transaction(db) {
            SchemaUtils.create(Users, Posts)
        }
    }

    override fun createPost(user: String,title: String, text: String, image: String, date: DateTime): Int = transaction(db) {
        Posts.insert {
            it[Posts.user] = user
            it[Posts.date] = date
            it[Posts.title] = title
            it[Posts.text] = text
            it[Posts.image] = image
        }.resultedValues?.firstOrNull()?.get(Posts.id) ?: error("No generated key returned")
    }

    override fun deletePost(id: Int) {
        transaction(db) {
            Posts.deleteWhere { Posts.id.eq(id) }
        }
    }

    override fun getPost(id: Int) = transaction(db) {
        val row = Posts.select { Posts.id.eq(id) }.single()
        Post(id, row[Posts.user], row[Posts.date], row[Posts.title],row[Posts.text], row[Posts.image])
    }

    override fun userPosts(userId: String) = transaction(db) {
        Posts.slice(Posts.id).select { Posts.user.eq(userId) }.orderBy(Posts.date, SortOrder.DESC).limit(100)
            .map { it[Posts.id] }
    }

    override fun user(userId: String, hash: String?) = transaction(db) {
        Users.select { Users.id.eq(userId) }
            .mapNotNull {
                if (hash == null || it[Users.passwordHash] == hash) {
                    User(userId, it[Users.email], it[Users.displayName], it[Users.profilePic], it[Users.passwordHash])
                } else {
                    null
                }
            }
            .singleOrNull()
    }

    override fun userByEmail(email: String) = transaction(db) {
        Users.select { Users.email.eq(email) }
            .map { User(it[Users.id], email, it[Users.displayName], it[Users.profilePic], it[Users.passwordHash]) }.singleOrNull()
    }

    override fun createUser(user: User) = transaction(db) {
        Users.insert {
            it[id] = user.userId
            it[displayName] = user.displayName
            it[email] = user.email
            it[profilePic] = user.profilePic
            it[passwordHash] = user.passwordHash
        }
        Unit
    }

    override fun allPosts(): List<Post> = transaction(db) {
        Posts.selectAll().map {
            Post(it[Posts.id],it[Posts.user],it[Posts.date],it[Posts.title],it[Posts.text],it[Posts.image])
        }
    }

    override fun allUsers(): List<User> = transaction(db) {
        Users.selectAll().map {
            User(it[Users.id], it[Users.email], it[Users.displayName], it[Users.profilePic], it[Users.passwordHash])
        }
    }

    override fun latest(count: Int): List<Int> = transaction(db) {
        Posts.selectAll()
                .orderBy(Posts.date, SortOrder.DESC)
                .limit(count)
                .map { it[Posts.id] }
    }

    override fun editUser(user: String, email: String, displayName: String, profilePic: String): Boolean = transaction(db) {
        Users.update({Users.id.eq(user)}) {
            it[Users.email] = email
            it[Users.displayName] = displayName
            it[Users.profilePic] = profilePic
        } > 0
    }

    override fun close() {
    }
}
