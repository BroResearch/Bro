package route

import dao.DAOFacade
import io.ktor.http.*
import io.ktor.resources.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.resources.*
import io.ktor.server.resources.post
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import kotlinx.serialization.Serializable
import plugin.BroSession
import plugin.isAdmin


/**
 * Data class representing the [Admin] page.
 */
@Serializable
@Resource("/admin")
data class Admin(val userId: String = "")


fun Route.admin(dao: DAOFacade) {
    /**
     * A GET request to the [Admin] page should display all users and provide an option to block/unblock them.
     * Only admin users should have access to this page.
     */
    get<Admin> {
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }
        if (user?.isAdmin() == false || user == null) {
            call.respond(HttpStatusCode.Forbidden)
        } else {
            val users = dao.allUsers().filter {
                it.userId != user?.userId
            }

            call.respond(
                FreeMarkerContent(
                    "admin.ftl",
                    mapOf("user" to user, "users" to users)
                )
            )
        }
    }

        /**
         * A POST request to the [Admin] page should delete the user.
         */
    post<Admin> {
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }
        if (user?.isAdmin() == false || user == null) {
            call.respond(HttpStatusCode.Forbidden)
        } else {
            val post = call.receive<Parameters>()
            val userId = post["userId"] ?: return@post call.respond(HttpStatusCode.BadRequest)
            //delete all user posts
            dao.userPosts(userId).forEach {
                dao.deletePost(it)
            }
            //and finally user
            dao.deleteUser(userId)
            call.respond(HttpStatusCode.OK)
        }
    }

}