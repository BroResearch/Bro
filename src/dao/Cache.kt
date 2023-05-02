package dao

import model.Post
import model.User
import org.ehcache.config.builders.CacheConfigurationBuilder
import org.ehcache.config.builders.CacheManagerBuilder
import org.ehcache.config.builders.ResourcePoolsBuilder
import org.ehcache.config.units.*
import org.ehcache.impl.config.persistence.CacheManagerPersistenceConfiguration
import org.joda.time.*
import java.io.*

/**
 * An Ehcache based implementation for the [DAOFacade] that uses a [delegate] facade and a [storagePath]
 * and perform several caching strategies for each domain operation.
 */
class DAOFacadeCache(private val delegate: DAOFacade, private val storagePath: File) : DAOFacade {

    /**
     * Build a cache manager with a cache for posts and other for users.
     * It uses the specified [storagePath] for persistence.
     * Limits the cache to 1000 entries, 10MB in memory, and 100MB in disk per both caches.
     */
    private val cacheManager = CacheManagerBuilder.newCacheManagerBuilder()
        .with(CacheManagerPersistenceConfiguration(storagePath))
        .withCache(
            "postsCache",
            CacheConfigurationBuilder.newCacheConfigurationBuilder<Int, Post>(
                Int::class.javaObjectType,
                Post::class.java,

                ResourcePoolsBuilder.newResourcePoolsBuilder()
                    .heap(1000, EntryUnit.ENTRIES)
                    .offheap(10, MemoryUnit.MB)
                    .disk(100, MemoryUnit.MB, true)
            )
        )
        .withCache(
            "usersCache",
            CacheConfigurationBuilder.newCacheConfigurationBuilder<String, User>(
                String::class.java,
                User::class.java,
                ResourcePoolsBuilder.newResourcePoolsBuilder()
                    .heap(1000, EntryUnit.ENTRIES)
                    .offheap(10, MemoryUnit.MB)
                    .disk(100, MemoryUnit.MB, true)
            )
        )
        .build(true)

    /**
     * Gets the cache for posts represented by an [Int] key and a [Post] value.
     */
    private val postsCache = cacheManager.getCache("postsCache", Int::class.javaObjectType, Post::class.java)

    /**
     * Gets the cache for users represented by a [String] key and a [User] value.
     */
    private val usersCache = cacheManager.getCache("usersCache", String::class.java, User::class.java)

    override fun init() {
        delegate.init()
    }

    override fun createPost(user: String,title: String, text: String, image: String, date: DateTime): Int {
        val id = delegate.createPost(user, title, text, image)
        val post = Post(id, user, date, title, text, image)
        postsCache.put(id, post)
        return id
    }

    override fun deletePost(id: Int) {
        delegate.deletePost(id)
        postsCache.remove(id)
    }

    override fun deleteUser(userId: String) {
        delegate.deleteUser(userId)
    }

    override fun getPost(id: Int): Post {
        // Returns a cached Post when available in the cache.
        val cached = postsCache.get(id)
        if (cached != null) {
            return cached
        }

        // If not available, we get it from the delegate and store it in the cache, so we can access it later.
        val post = delegate.getPost(id)
        postsCache.put(id, post)

        return post
    }

    override fun userPosts(userId: String): List<Int> {
        return delegate.userPosts(userId)
    }

    override fun user(userId: String, hash: String?): User? {
        // Returns a cached User when available in the cache.
        val cached = usersCache.get(userId)
        val user = if (cached == null) {
            val dbUser = delegate.user(userId)
            if (dbUser != null) {
                usersCache.put(userId, dbUser)
            }
            dbUser
        } else {
            cached
        }

        // Verifies that, if specified, the hash matches to the returned user.
        return when {
            user == null -> null
            hash == null -> user
            user.passwordHash == hash -> user
            else -> null
        }
    }

    override fun userByEmail(email: String): User? {
        return delegate.userByEmail(email)
    }

    override fun createUser(user: User) {
        if (usersCache.get(user.userId) != null) {
            throw IllegalStateException("User already exist")
        }

        delegate.createUser(user)
        usersCache.put(user.userId, user)
    }

    override fun allPosts(): List<Post> {
        return delegate.allPosts()
    }

    override fun allUsers(): List<User> {
        return delegate.allUsers()
    }

    override fun latest(count: Int): List<Int> {
        return delegate.latest(count)
    }

    override fun editUser(user: String, email: String, displayName: String, profilePic: String): Boolean {
        return delegate.editUser(user, email, displayName, profilePic)
    }

    override fun close() {
        cacheManager.use {
            delegate.close()
        }
    }
}
