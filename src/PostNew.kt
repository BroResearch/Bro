import dao.DAOFacade
import model.Post
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.request.*
import io.ktor.server.resources.*
import io.ktor.server.resources.post
import io.ktor.server.response.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import java.io.File

/**
 * Register routes for the [PostNew] route '/post-new'
 */
fun Route.postNew(dao: DAOFacade, hashFunction: (String) -> String) {
    /**
     * A GET request returns a page with a form to post a new Post in the case the user
     * is logged also generating a [code] token to prevent.
     *
     * If the user is not logged it redirects to the [Login] page.
     */
    get<PostNew> {
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }

        if (user == null) {
            call.redirect(Login())
        } else {
            val date = System.currentTimeMillis()
            val code = call.securityCode(date, user, hashFunction)

            call.respond(
                FreeMarkerContent(
                    "new-post.ftl",
                    mapOf("user" to user, "date" to date, "code" to code),
                    user.userId
                )
            )
        }
    }
    /**
     * A POST request actually tries to create a new [Post].
     * It validates the `date`, `code` and `text` parameters and redirects to the login page on failure.
     * On success, it creates the new [Post] and redirect to the [ViewPost] page to view that specific Post.
     */
    post<PostNew> {
        val user = call.sessions.get<BroSession>()?.let { dao.user(it.userId) }

//        val post = call.receive<Parameters>()
//        val date = post["date"]?.toLongOrNull() ?: return@post call.redirect(it)
//        val code = post["code"] ?: return@post call.redirect(it)
//        val text = post["text"] ?: return@post call.redirect(it)

        var date: Long = 0
        var code: String = ""
        var text: String = ""
        var fileName: String = ""
        val multipartData = call.receiveMultipart()

        multipartData.forEachPart { part ->
            when (part) {
                is PartData.FormItem -> {
                    when (part.name){
                        "date" -> date = part.value.toLong()
                        "code" -> code = part.value
                        "text" -> text = part.value
                    }
                }

                is PartData.FileItem -> {
                    fileName = part.originalFileName as String
                    val fileBytes = part.streamProvider().readBytes()
                    File("uploads/$fileName").writeBytes(fileBytes)
                }

                else -> {}
            }
            part.dispose()
        }


        if (user == null || !call.verifyCode(date, user, code, hashFunction)) {
            call.redirect(Login())
        } else {
            val id = dao.createPost(user.userId, text, null)
            call.redirect(ViewPost(id))
        }
    }
}