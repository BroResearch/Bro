package route

import dao.DAOFacade
import io.ktor.resources.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.resources.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.routing.get
import io.ktor.server.sessions.*
import kotlinx.serialization.Serializable
import plugin.BroSession
import kotlin.text.get


@Serializable
@Resource("/docs/api")
class ApiDocsPage
/**
 * Register the [ApiDocsPage] route '/docs/api'.
 */
fun Route.apiDocsPage(dao: DAOFacade) {
    get<ApiDocsPage> {
        // Tries to get the user from the session (null if failure)
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }

        // Uses FreeMarker to render the page.
        call.respond(
            FreeMarkerContent(
                "api-docs.ftl",
                mapOf("user" to user)
            )
        )
    }
}