import dao.DAOFacade
import dao.DAOFacadeCache
import dao.Posts
import io.ktor.http.*
import io.ktor.server.testing.*
import io.mockk.*
import model.Post
import model.User
import org.joda.time.*
import org.junit.Test
import plugin.hash
import kotlin.test.*
import route.Index
import route.UserPage
import route.Login
import plugin.mainWithDependencies

/**
 * Integration tests for the module [mainWithDependencies].
 *
 * Uses [testApp] in test methods to simplify the testing.
 */
class BroApplicationTestLegacy {
    /**
     * A [mockk] instance of the [DAOFacade] to used to verify and mock calls on the integration tests.
     */
    private val dao: DAOFacade = mockk(relaxed = true)

    /**
     * Specifies a fixed date for testing.
     */
    private val date: DateTime = DateTime.parse("2010-01-01T00:00+00:00")

    /**
     * Tests that the [Index] page calls the [DAOFacade.latest] methods just once.
     * And that when no [Posts] are available, it displays "There are no posts yet" somewhere.
     */
    @Test
    fun testEmptyHome() = testApp {
        every { dao.latest() } returns listOf()

        handleRequest(HttpMethod.Get, "/").apply {
            assertEquals(200, response.status()?.value)
            assertTrue(response.content!!.contains("There are no posts yet"))
        }

        verify(exactly = 1) { dao.latest() }
    }

    /**
     * Tests that the [Index] page calls the [DAOFacade.latest] methods just once.
     * And that when some Posts are available there is a call to [DAOFacade.getPost] per provided post id
     * (the final application will cache with [DAOFacadeCache]).
     * Ensures that it DOESN'T display "There are no posts yet" when there are posts available,
     * and that the user of the posts is also displayed.
     */
    @Test
    fun testHomeWithSomePosts() = testApp {
        every { dao.getPost(1) } returns Post(1, "user1", date, "title1", "text1","image1")
        every { dao.getPost(2) } returns Post(2, "user2", date, "title2","text2","image2")
        every { dao.latest() } returns listOf(2)

        handleRequest(HttpMethod.Get, "/").apply {
            assertEquals(200, response.status()?.value)
            assertFalse(response.content!!.contains("There are no posts yet"))
            assertTrue(response.content!!.contains("text2"))
        }

        verify(exactly = 1) { dao.latest() }
    }

    /**
     * Verifies the behaviour of a login failure. That it should be a redirection to the /user page.
     */
    @Test
    fun testLoginFail() = testApp {
        handleRequest(HttpMethod.Post, "/login") {
            addHeader(HttpHeaders.ContentType, ContentType.Application.FormUrlEncoded.toString())
            setBody(listOf("userId" to "myuser", "password" to "invalid").formUrlEncode())
        }.apply {
            assertEquals(302, response.status()?.value)
        }
    }

    /**
     * Verifies a chain of requests verifying the [Login].
     * It mocks a get [DAOFacade.user] request, checks that posting valid credentials to the /login form
     * redirects to the user [UserPage] for that user, and reuses the returned cookie for a request
     * to the [UserPage] and verifies that with that cookie/session, there is a "sign out" text meaning that
     * the user is logged in.
     */
    @Test
    fun testLoginSuccess() = testApp {
        val password = "mylongpassword"
        val passwordHash = hash(password)
        val sessionCookieName = "SESSION"
        lateinit var sessionCookie: Cookie
        every { dao.user("test1", passwordHash) } returns User("test1", "test1@test.com", "test1", "test1", passwordHash)

        handleRequest(HttpMethod.Post, "/login") {
            addHeader(HttpHeaders.ContentType, ContentType.Application.FormUrlEncoded.toString())
            setBody(listOf("userId" to "test1", "password" to password).formUrlEncode())
        }.apply {
            assertEquals(302, response.status()?.value)
            assertEquals("/user/test1", response.headers["Location"])
            assertEquals(null, response.content)
            sessionCookie = response.cookies[sessionCookieName]!!
        }

        handleRequest(HttpMethod.Get, "/") {
            addHeader(HttpHeaders.Cookie, "$sessionCookieName=${sessionCookie.value.encodeURLParameter()}")
        }.apply {
            assertTrue { response.content!!.contains("sign out") }
        }
    }

    /**
     * A private method used to reduce boilerplate when testing the application.
     */
    private fun testApp(callback: TestApplicationEngine.() -> Unit) {
        withTestApplication({ mainWithDependencies(dao) }) { callback() }
    }
}
