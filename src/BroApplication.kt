import io.ktor.server.application.*
import plugin.dao
import plugin.mainWithDependencies
import plugin.pool

/*
 * Classes are used by the Resources plugin to build URLs and register routes.
 */

/**
 * Entry Point of the application. This function is referenced in the
 * resources/application.conf file inside the ktor.application.modules.
 *
 * For more information about this file: https://ktor.io/docs/configurations.html#configuration-file
 */
fun Application.main() {
    // First, we initialize the database.
    dao.init()
    // Then, we subscribe to the stop event of the application, so we can also close the [ComboPooledDataSource] [pool].
    environment.monitor.subscribe(ApplicationStopped) { pool.close() }
    // Now we call to a main with the dependencies as arguments.
    // Separating this function with its dependencies allows us to provide several modules with
    // the same code and different datasources living in the same application,
    // and to provide mocked instances for doing integration tests.
    mainWithDependencies(dao)
}

