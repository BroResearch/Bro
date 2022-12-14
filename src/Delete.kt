import dao.DAOFacade
import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.resources.post
import io.ktor.server.request.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*

/**
 * Registers a route for deleting deleting posts.
 */
fun Route.delete(dao: DAOFacade, hashFunction: (String) -> String) {
    // Uses the Resources plugin to register a 'post' route for '/kweet/{id}/delete'.
    post<KweetDelete> {
        // Tries to get (null on failure) the user associated to the current PostSession
        val user = call.sessions.get<KweetSession>()?.let { dao.user(it.userId) }

        // Receives the Parameters date and code, if any of those fails to be obtained,
        // it redirects to the bro page without deleting the post.
        val post = call.receive<Parameters>()
        val date = post["date"]?.toLongOrNull() ?: return@post call.redirect(ViewKweet(it.id))
        val code = post["code"] ?: return@post call.redirect(ViewKweet(it.id))
        val kweet = dao.getPost(it.id)

        // Verifies that the post user matches the session user and that the code and the date match, to prevent CSFR.
        if (user == null || kweet.userId != user.userId || !call.verifyCode(date, user, code, hashFunction)) {
            call.redirect(ViewKweet(it.id))
        } else {
            dao.deletePost(it.id)
            call.redirect(Index())
        }
    }
}
