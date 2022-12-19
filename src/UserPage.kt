import dao.DAOFacade
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.resources.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

/**
 * Register the [UserPage] route '/user/{user}',
 * with the user profile.
 */
fun Route.userPage(dao: DAOFacade) {
    /**
     * A GET request will return a page with the profile of a given user from its [UserPage.user] name.
     * If the user doesn't exist, it will return a 404 page instead.
     */
    get<UserPage> {
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }
        val pageUser = dao.user(it.user)

        if (pageUser == null) {
            call.respond(HttpStatusCode.NotFound.description("User ${it.user} doesn't exist"))
        } else {
            val posts = dao.userPosts(it.user).map { dao.getPost(it) }
            val etag = (user?.userId ?: "") + "_" + posts.map { it.text.hashCode() }.hashCode().toString()

            call.respond(
                FreeMarkerContent(
                    "user.ftl",
                    mapOf("user" to user, "pageUser" to pageUser, "kweets" to posts),
                    etag
                )
            )
        }
    }
}
