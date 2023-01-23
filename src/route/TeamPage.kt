package route

import dao.DAOFacade
import io.ktor.http.*
import io.ktor.resources.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.resources.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import kotlinx.serialization.Serializable
import plugin.BroSession

@Serializable
@Resource("/team")
class TeamPage
/**
 * Register the [TeamPage] route '/team'.
 */
fun Route.teamPage(dao: DAOFacade) {
    get<TeamPage> {
        // Tries to get the user from the session (null if failure)
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }

        // Uses FreeMarker to render the page.
        call.respond(
            FreeMarkerContent(
                "team.ftl",
                mapOf("user" to user)
            )
        )
    }
}