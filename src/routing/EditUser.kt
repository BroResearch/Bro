package routing

import BroSession
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
import redirect

@Serializable
@Resource("/user/{user}/edit")
data class EditUser(val user: String)

fun Route.editUser(dao: DAOFacade) {
    get<EditUser> {
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }
        val pageUser = dao.user(it.user)

        if (user != pageUser && pageUser != null){
            call.redirect(UserPage(pageUser.userId))
        } else {
            call.respond(
                FreeMarkerContent(
                    "edit-user.ftl",
                    mapOf("user" to user)
                )
            )
        }
    }
}
