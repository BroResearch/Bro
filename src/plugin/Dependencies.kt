package plugin

import dao.DAOFacade
import freemarker.cache.ClassTemplateLoader
import io.ktor.serialization.kotlinx.json.*
import io.ktor.server.application.*
import io.ktor.server.freemarker.*
import io.ktor.server.plugins.callloging.*
import io.ktor.server.plugins.conditionalheaders.*
import io.ktor.server.plugins.contentnegotiation.*
import io.ktor.server.plugins.defaultheaders.*
import io.ktor.server.plugins.partialcontent.*
import io.ktor.server.resources.*
import io.ktor.server.routing.*
import io.ktor.server.sessions.*
import route.*

/**
 * This function is called from the entry point and tests to configure an application
 * using the specified [dao] [DAOFacade].
 */
fun Application.mainWithDependencies(dao: DAOFacade) {
    // This adds the Date and Server headers to each response and would allow you to configure
    // additional headers served to each response.
    install(DefaultHeaders)
    // This uses the logger to log every call (request/response)
    install(CallLogging)
    // Automatic '304 Not Modified' Responses
    install(ConditionalHeaders)
    // Supports for Range, Accept-Range and Content-Range headers
    install(PartialContent)
    // Allows using classes annotated with @Resource to represent URLs.
    // They are typed, can be constructed to generate URLs, and can be used to register routes.
    install(Resources)
    // Adds support to generate templated responses using FreeMarker.
    // We configure it specifying the path inside the resources to use to get the template files.
    // You can use <!-- @ftlvariable --> to annotate types inside the templates
    // in a way that works with IntelliJ IDEA Ultimate.
    // You can check the `resources/templates/*.ftl` files for reference.
    install(FreeMarker) {
        templateLoader = ClassTemplateLoader(this::class.java.classLoader, "templates")
    }
    // Configure the session to be represented by a [BroSession],
    // using the SESSION cookie to store it, and transforming it to be authenticated with the [hashKey].
    // it is sent in a plain text, but since it is authenticated can't be modified without knowing the secret [hashKey].
    install(Sessions) {
        cookie<BroSession>("SESSION") {
            transform(SessionTransportTransformerMessageAuthentication(hashKey))
        }
    }

    // provide a convenient mechanism for converting Kotlin objects into a serialized form like JSON,
    // and vice versa. We will use it to format our APIs output,
    // and to consume user input that is structured in JSON.
    install(ContentNegotiation) {
        json()
    }

    // Provides a hash function to be used when registering the resources.
    val hashFunction = { s: String -> hash(s) }

    // Register all the routes available to the application.
    // They are split in several methods and files, so it can scale for larger
    // applications keeping a reasonable number of lines per file.
    routing {
        postsRouting(dao)
        usersRouting(dao)
        scripts()
        styles()
        uploads()
        apiDocsPage(dao)
        teamPage(dao)
        index(dao)
        postNew(dao, hashFunction)
        delete(dao, hashFunction)
        userPage(dao)
        viewPost(dao, hashFunction)
        editUser(dao, hashFunction)
        login(dao, hashFunction)
        register(dao, hashFunction)
    }
}
