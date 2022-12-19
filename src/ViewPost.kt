import dao.DAOFacade
import io.ktor.resources.*
import model.Post
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.resources.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import kotlinx.serialization.Serializable

@Serializable
@Resource("/post/{id}")
data class ViewPost(val id: Int)

/**
 * Registers the [ViewPost] route. (/post/{id})
 */
fun Route.viewPost(dao: DAOFacade, hashFunction: (String) -> String) {
    /**
     * This page shows the [Post] content and its replies.
     * If there is a user logged in, and the post is from her/him, it will provide secured links to remove it.
     */
    get<ViewPost> {
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }
        val date = System.currentTimeMillis()
        val code = if (user != null) call.securityCode(date, user, hashFunction) else null

        call.respond(
            FreeMarkerContent(
                "view-post.ftl",
                mapOf("user" to user, "kweet" to dao.getPost(it.id), "date" to date, "code" to code),
                user?.userId ?: ""
            )
        )
    }
}
