import dao.DAOFacade
import io.ktor.resources.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.resources.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import kotlinx.serialization.Serializable

@Serializable
@Resource("/")
class Index

/**
 * Register the index route of the website.
 */
fun Route.index(dao: DAOFacade) {
    // Uses the Location plugin to register a get route for '/'.
    get<Index> {
        // Tries to get the user from the session (null if failure)
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }

        // Obtains several lists of posts using different sorting and filters.
//        val top = dao.top(10).map { dao.getPost(it) }
        val posts = dao.latest(10).map { dao.getPost(it) }

        // Generates an ETag unique string for this route that will be used for caching.
        val etagString =
            user?.userId + "," + posts.joinToString { it.id.toString() }
        val etag = etagString.hashCode()

        // Uses FreeMarker to render the page.
        call.respond(
            FreeMarkerContent(
                "index.ftl",
                mapOf("posts" to posts, "user" to user),
                etag.toString()
            )
        )
    }
}
