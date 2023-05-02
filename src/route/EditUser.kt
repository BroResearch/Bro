package route

import dao.DAOFacade
import io.ktor.http.*
import io.ktor.http.content.*
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
import plugin.*
import java.io.File

@Serializable
@Resource("/user/{user}/edit")
data class EditUser(val user: String)
/**
 * Register routes for user registration in the [EditUser] route (/user/{user}/edit)
 */
fun Route.editUser(dao: DAOFacade, hashFunction: (String) -> String) {
    get<EditUser> {
        // get current session data if any
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }
        val pageUser = dao.user(it.user)

        if (user != pageUser && pageUser != null){
            call.redirect(UserPage(pageUser.userId))
        } else {
            val date = System.currentTimeMillis()
            val code = call.securityCode(date, user!!, hashFunction)

            call.respond(
                FreeMarkerContent(
                    "edit-user.ftl",
                    mapOf("user" to user, "date" to date, "code" to code)
                )
            )
        }
    }
    post<EditUser> { it ->
        try {
            val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }

            var date: Long = 0
            var code: String = ""

            var email: String = ""
            var displayName: String = ""
            var profilePic: String = ""

            var fileBytes: ByteArray = byteArrayOf()

            val multipartData = call.receiveMultipart()

            multipartData.forEachPart { part ->
                when (part) {
                    is PartData.FormItem -> {
                        when (part.name){
                            "date" -> date = part.value.toLong()
                            "code" -> code = part.value
                            "email" -> email = part.value
                            "display-name" -> displayName = part.value
                        }
                    }

                    is PartData.FileItem -> {
                        profilePic = part.originalFileName as String
                        fileBytes = part.streamProvider().readBytes()
                        File("uploads/$profilePic").writeBytes(fileBytes)
                    }

                    else -> {}
                }
                part.dispose()
            }
            // Verifies that the post user matches the session user and that the code and the date match, to prevent CSFR.
            if (user == null || !call.verifyCode(date, user, code, hashFunction)) {
                call.redirect(UserPage(it.user))
            } else {
                dao.editUser(it.user,email,displayName,profilePic)
                call.redirect(UserPage(it.user))
            }
        } catch (e: Exception) {
            call.respond(HttpStatusCode.InternalServerError, e.message.toString())
        }
    }

}
