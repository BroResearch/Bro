package route

import io.ktor.http.*
import io.ktor.resources.*
import io.ktor.server.application.*
import io.ktor.server.http.content.*
import io.ktor.server.resources.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.serialization.Serializable
import java.io.File

@Serializable
@Resource("/uploads/{imageName}")
class Uploads

/**
 * Register the uploads, [Uploads] route (/uploads/{imageName})
 */
fun Route.uploads() {
    /**
     * On a GET request to the [Uploads] route, it returns the `upload` file from the resources.
     */
    get<Uploads> {
        val imageName = call.parameters["imageName"]
        val file = File("./uploads/$imageName")

        with(file){
            if (this.exists()){
                call.respondFile(this)
            } else {
                call.respondText("Image not found", status = HttpStatusCode.NotFound)
            }
        }
    }
}