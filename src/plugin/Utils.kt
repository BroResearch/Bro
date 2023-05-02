package plugin

import com.mchange.v2.c3p0.ComboPooledDataSource
import dao.DAOFacade
import dao.DAOFacadeCache
import dao.DAOFacadeDatabase
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.request.*
import io.ktor.server.resources.*
import io.ktor.server.response.*
import io.ktor.util.*
import model.User
import org.h2.Driver
import org.jetbrains.exposed.sql.Database
import java.io.File
import java.net.URI
import java.util.concurrent.TimeUnit
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec

/**
 * Represents a session in this site containing the user ID.
 */
data class BroSession(val userId: String)

fun User.isAdmin() = userId == "admin"


/**
 * A hardcoded secret hash key used to hash the passwords, and to authenticate the sessions.
 */
val hashKey = hex("6819b57a326945c1968f45236589")

/**
 * A file where the database is going to be stored.
 */
val dir = File("build/db")

/**
 * A pool of JDBC connections.
 */
val pool = ComboPooledDataSource().apply {
    driverClass = Driver::class.java.name
    jdbcUrl = "jdbc:h2:file:${dir.canonicalFile.absolutePath}"
    user = ""
    password = ""
}

/**
 * HMac SHA1 key spec for the password hashing.
 */
val hmacKey = SecretKeySpec(hashKey, "HmacSHA1")

/**
 * Constructs a facade with the database, connected to the DataSource configured earlier with the [dir]
 * for storing the database.
 */
val dao: DAOFacade = DAOFacadeCache(DAOFacadeDatabase(Database.connect(pool)), File(dir.parentFile, "ehcache"))


/**
 * Hashes a [password] by using the globally defined secret key [hmacKey].
 */
fun hash(password: String): String {
    val hmac = Mac.getInstance("HmacSHA1")
    hmac.init(hmacKey)
    return hex(hmac.doFinal(password.toByteArray(Charsets.UTF_8)))
}

/**
 * Allows responding with a relative redirect to a typed instance of a class annotated
 * with @Resource using the Resources plugin.
 */
suspend inline fun <reified T: Any> ApplicationCall.redirect(resource: T) {
    respondRedirect(application.href(resource))
}

/**
 * Generates a security code using a [hashFunction], a [date], a [user] and an implicit [HttpHeaders.Referrer]
 * to generate tokens to prevent CSRF attacks.
 */
fun ApplicationCall.securityCode(date: Long, user: User, hashFunction: (String) -> String) =
    hashFunction("$date:${user.userId}:${request.host()}:${refererHost()}")

/**
 * Verifies that a code generated from [securityCode] is valid for a [date] and a [user] and an implicit [HttpHeaders.Referrer].
 * It should match the generated [securityCode] and also not be older than two hours.
 * Used to prevent CSRF attacks.
 */
fun ApplicationCall.verifyCode(date: Long, user: User, code: String, hashFunction: (String) -> String) =
    securityCode(date, user, hashFunction) == code &&
            (System.currentTimeMillis() - date).let { it > 0 && it < TimeUnit.MILLISECONDS.convert(2, TimeUnit.HOURS) }

/**
 * Obtains the [refererHost] from the [HttpHeaders.Referrer] header, to check it to prevent CSRF attacks
 * from other domains.
 */
fun ApplicationCall.refererHost() = request.header(HttpHeaders.Referrer)?.let { URI.create(it).host }

/**
 * Pattern to validate an `userId`
 */
private val userIdPattern = "[a-zA-Z0-9_.]+".toRegex()

/**
 * Validates that an [userId] (that is also the username) is a valid identifier.
 * Here we could add additional checks like the length of the user.
 * Or other things like a bad word filter.
 */
internal fun userNameValid(userId: String) = userId.matches(userIdPattern)
