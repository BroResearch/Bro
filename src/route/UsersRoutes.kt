package route

import dao.DAOFacade
import io.ktor.http.*
import io.ktor.resources.*
import io.ktor.server.application.*
import io.ktor.server.resources.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.serialization.Serializable

@Serializable
@Resource("/v1/users")
class UsersRoutes{
    @Serializable
    @Resource("{user}")
    class Id(val parent: UsersRoutes = UsersRoutes(), val user: String)
}
/**
 * Registers the [UsersRoutes] route for th REST Api.
 */
fun Route.usersRouting(dao: DAOFacade) {
    get<UsersRoutes> {
        val users = dao.allUsers()
        call.respond(users)
    }

    get<UsersRoutes.Id> {
        val user = dao.user(it.user) ?: return@get call.respondText(
            "No user with id ${it.user}",
            status = HttpStatusCode.NotFound
        )
        call.respond(user)
    }
}
