import io.ktor.server.application.*
import plugin.dao
import plugin.mainWithDependencies
import plugin.pool
import com.mchange.v2.c3p0.ComboPooledDataSource

/**
 * Entry Point of the application.
 */
fun Application.main() {
    // First, we initialize the database.
    dao.init()
    /**
     * Then, we subscribe to the stop event of the application, so we can also close the [ComboPooledDataSource] [pool].
     */
    environment.monitor.subscribe(ApplicationStopped) { pool.close() }
    // Now we call to a main with the dependencies as arguments.
    mainWithDependencies(dao)
}

