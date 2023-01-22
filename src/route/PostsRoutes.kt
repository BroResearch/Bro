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
@Resource("/v1/posts")
class PostsRoutes{
    @Serializable
    @Resource("{id}")
    class Id(val parent: PostsRoutes = PostsRoutes(),val id: Int)
}


fun Route.postsRouting(dao: DAOFacade) {
    get<PostsRoutes> {
        val posts = dao.allPosts()
        call.respond(posts)
    }

    get<PostsRoutes.Id> {
        val post = dao.getPost(it.id)
        if (post.equals(null)) return@get call.respondText(
            "No post with id ${it.id}",
            status = HttpStatusCode.NotFound
        ) else call.respond(post)
    }
}
