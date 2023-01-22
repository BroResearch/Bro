import dao.DAOFacade
import io.ktor.http.*
import io.ktor.server.testing.*
import io.mockk.*
import model.User
import org.joda.time.*
import org.junit.Test
import plugin.hash
import plugin.mainWithDependencies
import kotlin.test.*

class BroApplicationWithTrackCookiesTestLegacy {
    private val dao: DAOFacade = mockk(relaxed = true)
    private val date: DateTime = DateTime.parse("2010-01-01T00:00+00:00")

    /**
     * This test is analogous to [BroApplicationTestLegacy.testLoginSuccess] but uses the [cookiesSession] method
     * to simplify the cookie tracking in several requests.
     */
    @Test
    fun testLoginSuccessWithTracker() = testApp {
        val password = "mylongpassword"
        val passwordHash = hash(password)
        every { dao.user("test1", passwordHash) } returns User("test1", "test1@test.com", "test1", "test1", passwordHash)

        cookiesSession {
            handleRequest(HttpMethod.Post, "/login") {
                addHeader(HttpHeaders.ContentType, ContentType.Application.FormUrlEncoded.toString())
                setBody(listOf("userId" to "test1", "password" to password).formUrlEncode())
            }.apply {
                assertEquals(302, response.status()?.value)
                assertEquals("/user/test1", response.headers["Location"])
                assertEquals(null, response.content)
            }

            handleRequest(HttpMethod.Get, "/").apply {
                assertTrue { response.content!!.contains("sign out") }
            }
        }
    }

    private fun testApp(callback: TestApplicationEngine.() -> Unit) {
        withTestApplication(moduleFunction = { mainWithDependencies(dao) }) { callback() }
    }
}

private class CookieTrackerTestApplicationEngine(
    val engine: TestApplicationEngine,
    var trackedCookies: List<Cookie> = listOf()
)

private fun CookieTrackerTestApplicationEngine.handleRequest(
    method: HttpMethod,
    uri: String,
    setup: TestApplicationRequest.() -> Unit = {}
): TestApplicationCall {
    return engine.handleRequest(method, uri) {
        val cookieValue =
            trackedCookies.joinToString("; ") { (it.name).encodeURLParameter() + "=" + (it.value).encodeURLParameter() }
        addHeader(HttpHeaders.Cookie, cookieValue)
        setup()
    }.apply {
        trackedCookies = response.headers.values(HttpHeaders.SetCookie).map { parseServerSetCookieHeader(it) }
    }
}

private fun TestApplicationEngine.cookiesSession(
    initialCookies: List<Cookie> = listOf(),
    callback: CookieTrackerTestApplicationEngine.() -> Unit
) {
    callback(CookieTrackerTestApplicationEngine(this, initialCookies))
}
