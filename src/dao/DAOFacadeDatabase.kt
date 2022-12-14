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
     * In this case, this should initialize the Users and Posts tables.
     */
    fun init()

    /**
     * Counts the number of replies of a post identified by its [id].
     */
    fun countReplies(id: Int): Int

    /**
     * Creates a Post from a specific [user] name, the Post [text] content,
     * an optional [replyTo] id of the parent post, and a [date] that would default to the current time.
     */
    fun createPost(user: String, text: String, replyTo: Int? = null, date: DateTime = DateTime.now()): Int

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
     * Returns a list of Post ids, with the ones with most replies first.
     */
    fun top(count: Int = 10): List<Int>

    /**
     * Returns a list of Post ids, with the recent ones first.
     */
    fun latest(count: Int = 10): List<Int>
}

/**
 * Database implementation of the facade.
 * Uses Exposed, and either an in-memory H2 database or a file-based H2 database by default.
 * But it can be configured.
 */
class DAOFacadeDatabase(
    private val db: Database = Database.connect("jdbc:h2:mem:test", driver = "org.h2.Driver")
) : DAOFacade {
    constructor(dir: File) : this(
        Database.connect(
            "jdbc:h2:file:${dir.canonicalFile.absolutePath}",
            driver = "org.h2.Driver"
        )
    )

    override fun init() {
        // Create the used tables
        transaction(db) {
            SchemaUtils.create(Users, Posts)
        }
    }

    override fun countReplies(id: Int): Int = transaction(db) {
        (Posts.slice(Posts.id.count()).select {
            Posts.replyTo.eq(id)
        }.single()[Posts.id.count()]).toInt()
    }

    override fun createPost(user: String, text: String, replyTo: Int?, date: DateTime): Int = transaction(db) {
        Posts.insert {
            it[Posts.user] = user
            it[Posts.date] = date
            it[Posts.replyTo] = replyTo
            it[Posts.text] = text
        }.resultedValues?.firstOrNull()?.get(Posts.id) ?: error("No generated key returned")
    }

    override fun deletePost(id: Int) {
        transaction(db) {
            Posts.deleteWhere { Posts.id.eq(id) }
        }
    }

    override fun getPost(id: Int) = transaction(db) {
        val row = Posts.select { Posts.id.eq(id) }.single()
        Post(id, row[Posts.user], row[Posts.text], row[Posts.date], row[Posts.replyTo])
    }

    override fun userPosts(userId: String) = transaction(db) {
        Posts.slice(Posts.id).select { Posts.user.eq(userId) }.orderBy(Posts.date, SortOrder.DESC).limit(100)
            .map { it[Posts.id] }
    }

    override fun user(userId: String, hash: String?) = transaction(db) {
        Users.select { Users.id.eq(userId) }
            .mapNotNull {
                if (hash == null || it[Users.passwordHash] == hash) {
                    User(userId, it[Users.email], it[Users.displayName], it[Users.passwordHash])
                } else {
                    null
                }
            }
            .singleOrNull()
    }

    override fun userByEmail(email: String) = transaction(db) {
        Users.select { Users.email.eq(email) }
            .map { User(it[Users.id], email, it[Users.displayName], it[Users.passwordHash]) }.singleOrNull()
    }

    override fun createUser(user: User) = transaction(db) {
        Users.insert {
            it[id] = user.userId
            it[displayName] = user.displayName
            it[email] = user.email
            it[passwordHash] = user.passwordHash
        }
        Unit
    }

    override fun top(count: Int): List<Int> = transaction(db) {
        // note: In a real application, you shouldn't do it like this
        //   as it may cause database outages on big data
        //   so this implementation is just for demo purposes

        val k2 = Posts.alias("k2")
        Posts.join(k2, JoinType.LEFT, Posts.id, k2[Posts.replyTo])
            .slice(Posts.id, k2[Posts.id].count())
            .selectAll()
            .groupBy(Posts.id)
            .orderBy(k2[Posts.id].count(), SortOrder.DESC)
//                .having { k2[Kweets.id].count().greater(0) }
            .limit(count)
            .map { it[Posts.id] }
    }

    override fun latest(count: Int): List<Int> = transaction(db) {
        var attempt = 0
        var allCount: Int? = null

        for (minutes in generateSequence(2) { it * it }) {
            attempt++

            val dt = DateTime.now().minusMinutes(minutes)

            val all = Posts.slice(Posts.id)
                .select { Posts.date.greater(dt) }
                .orderBy(Posts.date, SortOrder.DESC)
                .limit(count)
                .map { it[Posts.id] }

            if (all.size >= count) {
                return@transaction all
            }
            if (attempt > 10 && allCount == null) {
                allCount = Posts.slice(Posts.id.count()).selectAll().count().toInt()
                if (allCount <= count) {
                    return@transaction Posts.slice(Posts.id).selectAll().map { it[Posts.id] }
                }
            }
        }

        emptyList()
    }

    override fun close() {
    }
}
