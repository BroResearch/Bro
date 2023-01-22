import dao.DAOFacade
import io.ktor.client.plugins.cookies.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.server.config.*
import io.ktor.server.testing.*
import io.mockk.*
import model.Post
import model.User
import org.joda.time.*
import org.junit.Test
import plugin.hash
import plugin.mainWithDependencies
import kotlin.test.*

/**
 * Integration tests for the [main] module.
 */
class BroApplicationTest {
    /**
     * A [mockk] instance of the [DAOFacade] to used to verify and mock calls on the integration tests.
     */
    private val dao: DAOFacade = mockk(relaxed = true)

    /**
     * Specifies a fixed date for testing.
     */
    private val date: DateTime = DateTime.parse("2010-01-01T00:00+00:00")

    @Test
    fun testEmptyHome() = testApplication {
        setupApp()

        every { dao.latest() } returns listOf()

        client.get("/").apply {
            assertEquals(200, status.value)
            assertTrue(bodyAsText().contains("There are no posts yet"))
        }

        verify(exactly = 1) { dao.latest() }
    }

    @Test
    fun testHomeWithSomePosts() = testApplication {
        setupApp()

        every { dao.getPost(1) } returns Post(1, "user1", date, "title1","text1","image1")
        every { dao.getPost(2) } returns Post(2, "user2", date, "title2","text2","image2")
        every { dao.latest() } returns listOf(2)

        client.get("/").apply {
            assertEquals(200, status.value)
            assertFalse(bodyAsText().contains("There are no posts yet"))
            assertTrue(bodyAsText().contains("text2"))
        }

        verify(exactly = 1) { dao.latest() }
    }

    /**
     * Verifies the behaviour of a login failure. That it should be a redirection to the /user page.
     */
    @Test
    fun testLoginFail() = testApplication {
        setupApp()

        client.post("/login") {
            header(HttpHeaders.ContentType, ContentType.Application.FormUrlEncoded.toString())
            setBody(listOf("userId" to "myuser", "password" to "invalid").formUrlEncode())
        }.apply {
            assertEquals(302, status.value)
        }
    }

    @Test
    fun testLoginSuccess() = testApplication {
        setupApp()
        val client = createClient {
            install(HttpCookies)
        }

        val password = "mylongpassword"
        val passwordHash = hash(password)
        every { dao.user("test1", passwordHash) } returns User("test1", "test1@test.com", "test1","test1", passwordHash)

        client.post("/login") {
            header(HttpHeaders.ContentType, ContentType.Application.FormUrlEncoded.toString())
            setBody(listOf("userId" to "test1", "password" to password).formUrlEncode())
        }.apply {
            assertEquals(302, status.value)
            assertEquals("/user/test1", headers["Location"])
        }

        client.get("/").apply {
            assertEquals(200, status.value)
            assertTrue(bodyAsText().contains("sign out"))
        }
    }

    private fun ApplicationTestBuilder.setupApp() {
        application {
            mainWithDependencies(dao)
        }
        environment {
            config = MapApplicationConfig()
        }
    }
}
