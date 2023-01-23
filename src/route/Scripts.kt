package route

import io.ktor.resources.*
import io.ktor.server.application.*
import io.ktor.server.http.content.*
import io.ktor.server.resources.*
import io.ktor.server.response.*
import io.ktor.server.routing.*
import kotlinx.serialization.Serializable


@Serializable
@Resource("/scripts/main.js")
class MainJs

/**
 * Register the styles, [MainJs] route (/scripts/main.js)
 */
fun Route.scripts() {
    /**
     * On a GET request to the [MainJs] route, it returns the `script.js` file from the resources.
     */
    get<MainJs> {
        call.respond(call.resolveResource("script.js")!!)
    }
}