package io.ktor.samples.kweet

import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.samples.kweet.dao.*
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
     * A GET request returns a page with a form to post a new Kweet in the case the user
     * is logged also generating a [code] token to prevent.
     *
     * If the user is not logged it redirects to the [Login] page.
     */
    get<PostNew> {
        val user = call.sessions.get<KweetSession>()?.let { dao.user(it.userId) }

        if (user == null) {
            call.redirect(Login())
        } else {
            val date = System.currentTimeMillis()
            val code = call.securityCode(date, user, hashFunction)

            call.respond(
                FreeMarkerContent(
                    "new-kweet.ftl",
                    mapOf("user" to user, "date" to date, "code" to code),
                    user.userId
                )
            )
        }
    }
    /**
     * A POST request actually tries to create a new [Kweet].
     * It validates the `date`, `code` and `text` parameters and redirects to the login page on failure.
     * On success, it creates the new [Kweet] and redirect to the [ViewKweet] page to view that specific Kweet.
     */
    post<PostNew> {
        val user = call.sessions.get<KweetSession>()?.let { dao.user(it.userId) }

        val date = ""
        val code = ""
        var text = ""
        var image = ""

        val multiPartData = call.receive<MultiPartData>()

        multiPartData.forEachPart {part ->
            when(part) {
                is PartData.FormItem -> {
                    when(part.name){
                        "post-text" -> text = part.value
                        "date" -> date = part.value
                        "code" -> code = part.value
                    }
                }
                is PartData.FileItem -> {
                    image = part.originalFileName as String
                    val fileBytes = part.streamProvider().readBytes()

                    File("uploads/$image").writeBytes(fileBytes)
                }
                else -> {}
            }
            part.dispose()

        }

        if (user == null || !call.verifyCode(date, user, code, hashFunction)) {
            call.redirect(Login())
        } else {
            val id = dao.createKweet(user.userId, text, null, image)
            call.redirect(ViewKweet(id))
        }
    }
}