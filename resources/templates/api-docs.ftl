<#import "template.ftl" as layout />

<@layout.mainLayout title="API documentation">
    <div class="relative px-4 pt-14 sm:px-6 lg:px-8">
        <main>
            <article class="prose">
                <h1 class="text-xl text-foreground">API docs</h1>
                <p class="lead text-foreground">The Bro API allows programmatic access to Bro in unique and advanced ways. Take advantage of core Bro elements like: Posts, Users and more.</p>
                <h2 id="the-post-model" class="scroll-mt-24 text-cyan mt-10"><a
                            class="group text-inherit no-underline hover:text-inherit" href="#the-post-model">The
                        POST model</a></h2>
                <p class="text-foreground">The post model contains all the information about your post, such as their title, body text, image and
                    user id of the creator. It also contains the timestamp of when the post was created.</p>
                <h3 class="text-xl text-foreground mt-10">POST Properties</h3>
                <div class="my-6">
                    <ul role="list"
                        class="m-0 max-w-[calc(theme(maxWidth.lg)-theme(spacing.8))] list-none divide-y divide-zinc-900/5 p-0 dark:divide-white/5">
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>id</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">int</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>Unique identifier for the post.</p>
                                </dd>
                            </dl>
                        </li>
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>userId</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">string</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>The id of the user that created the post.</p>
                                </dd>
                            </dl>
                        </li>
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>date</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">long</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>Timestamp of when the post was created.</p>
                                </dd>
                            </dl>
                        </li>
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>title</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">string</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>Title for the post.</p>
                                </dd>
                            </dl>
                        </li>
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>text</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">string</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>The body for the post.</p>
                                </dd>
                            </dl>
                        </li>
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>image</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">string</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>Name of the uploaded image to create the post.</p>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                </div>
                <hr>
                <div class="flex items-center gap-x-3 mt-10"><span
                            class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-cyan bg-comment text-cyan">GET</span><span
                            class="h-0.5 w-0.5 rounded-full bg-zinc-300 dark:bg-zinc-600"></span><span
                            class="font-mono text-xs text-cyan">/v1/posts</span></div>
                <h2 id="list-all-posts" class="mt-2 scroll-mt-32"><a
                            class="group text-cyan no-underline" href="#list-all-posts">List all
                        posts</a></h2>
                <div class="grid grid-cols-1 items-start gap-x-16 xl:max-w-none xl:grid-cols-2">
                    <div class="first:mt-0 last:mb-0 text-foreground">
                        <p>This endpoint allows you to retrieve a list of all the posts.</p>

                    </div>
                    <div class="first:mt-0 last:mb-0 xl:sticky xl:top-24 text-foreground">
                        <div
                                class="not-prose my-4 overflow-hidden rounded-2xl bg-zinc-900 shadow-md dark:ring-1 dark:ring-white/10">
                            <div
                                    class="flex min-h-[calc(theme(spacing.12)+1px)] flex-wrap items-start gap-x-4 border-b border-purple bg-background px-4">
                                <h3 class="mr-auto pt-3 text-xs font-semibold text-foreground">Request</h3>
                                <div class="-mb-px flex gap-4 text-xs font-medium" role="tablist" aria-orientation="horizontal">
                                    <button
                                            class="border-b py-3 transition focus:[&:not(:focus-visible)]:outline-none border-emerald-500 text-purple"
                                            id="headlessui-tabs-tab-:r67:" role="tab" type="button" aria-selected="true" tabindex="0"
                                            data-headlessui-state="selected"
                                            aria-controls="headlessui-tabs-panel-:r6b:">cURL</button>
                                </div>
                            </div>
                            <div>
                                <div id="headlessui-tabs-panel-:r63:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r5v:"
                                     tabindex="0" data-headlessui-state="selected">
                                    <div class="group bg-background">
                                        <div
                                                class="flex h-9 items-center gap-2 border-y border-t-transparent border-purple bg-zinc-900 bg-white/2.5 px-4">
                                            <div class="dark flex"><span
                                                        class="font-mono text-[0.625rem] font-semibold leading-6 text-cyan">GET</span>
                                            </div><span class="h-0.5 w-0.5 rounded-full bg-zinc-500"></span><span
                                                    class="font-mono text-xs text-zinc-400">/v1/posts</span>
                                        </div>
                                        <div class="relative">
                          <pre class="overflow-x-auto p-4 text-xs text-white"><code class="language-bash"><span><span>curl -G https://api.bro.social/v1/posts \</span></span>
                          <span><span>  -H </span><span>"Content-Type: application/json"</span><span> \</span></span>
                          <span></span></code></pre>
                                        </div>
                                    </div>
                                </div><span id="headlessui-tabs-panel-:r64:" role="tabpanel"
                                            aria-labelledby="headlessui-tabs-tab-:r60:" tabindex="-1"
                                            style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span><span
                                        id="headlessui-tabs-panel-:r65:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r61:"
                                        tabindex="-1"
                                        style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span><span
                                        id="headlessui-tabs-panel-:r66:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r62:"
                                        tabindex="-1"
                                        style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span>
                            </div>
                        </div>
                        <div
                                class="not-prose my-6 overflow-hidden rounded-2xl bg-zinc-900 shadow-md bg-background">
                            <div
                                    class="flex min-h-[calc(theme(spacing.12)+1px)] flex-wrap items-start gap-x-4 border-b border-purple px-4">
                                <h3 class="mr-auto pt-3 text-xs font-semibold text-white">Response</h3>
                            </div>
                            <div class="group dark:bg-white/2.5">
                                <div class="relative">
                      <pre class="overflow-x-auto p-4 text-xs text-white"><code class="language-json">
                        <span><span>[</span></span>
                        <span>  </span><span>{</span>
                          <span>  </span><span class="text-green">"id"</span><span>:</span><span> </span><span class="text-cyan">1</span><span>,</span>
                          <span>  </span><span class="text-green">"userId"</span><span>:</span><span> </span><span class="text-cyan">"elonmusk"</span><span>,</span>
                          <span>  </span><span class="text-green">"date"</span><span>:</span><span> </span><span class="text-cyan">1674421325326</span><span>,</span>
                          <span>  </span><span class="text-green">"title"</span><span>:</span><span> </span><span class="text-cyan">"Este es el titulo del post"</span><span>,</span>
                          <span>  </span><span class="text-green">"text"</span><span>:</span><span> </span><span class="text-cyan">"Esto es el texto del post"</span><span>,</span>
                          <span>  </span><span class="text-green">"image"</span><span>:</span><span> </span><span class="text-cyan">"imagen_02.png"</span><span>,</span>
                          <span>}</span>
                          <span>  </span><span>{</span>
                          <span>     </span><span class="text-green">"id"</span><span>:</span><span> </span><span class="text-cyan">2</span><span>,</span>
                          <span>     </span><span class="text-currentLine">// ...</span>
                        <span>  </span><span>}</span>
                        <span><span>[</span></span>
                      </code></pre>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="flex items-center gap-x-3 mt-10"><span
                            class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-cyan bg-comment text-cyan">GET</span><span
                            class="h-0.5 w-0.5 rounded-full bg-zinc-300 dark:bg-zinc-600"></span><span
                            class="font-mono text-xs text-cyan">/v1/posts/:id</span></div>
                <h2 id="retrieve-a-post" class="mt-2 scroll-mt-32">
                    <a class="group text-cyan no-underline" href="#retrieve-a-post">Retrieve a Post</a></h2>
                <div class="grid grid-cols-1 items-start gap-x-16 xl:max-w-none xl:grid-cols-2">
                    <div class="first:mt-0 last:mb-0 text-foreground">
                        <p>This endpoint allows you to retrieve a post by providing their Post id.</p>
                    </div>
                    <div class="first:mt-0 last:mb-0 xl:sticky xl:top-24 text-foreground">
                        <div
                                class="not-prose my-4 overflow-hidden rounded-2xl bg-zinc-900 shadow-md dark:ring-1 dark:ring-white/10">
                            <div
                                    class="flex min-h-[calc(theme(spacing.12)+1px)] flex-wrap items-start gap-x-4 border-b border-purple bg-background px-4">
                                <h3 class="mr-auto pt-3 text-xs font-semibold text-foreground">Request</h3>
                                <div class="-mb-px flex gap-4 text-xs font-medium" role="tablist" aria-orientation="horizontal">
                                    <button
                                            class="border-b py-3 transition focus:[&:not(:focus-visible)]:outline-none border-emerald-500 text-purple"
                                            id="headlessui-tabs-tab-:r67:" role="tab" type="button" aria-selected="true" tabindex="0"
                                            data-headlessui-state="selected"
                                            aria-controls="headlessui-tabs-panel-:r6b:">cURL</button>
                                </div>
                            </div>
                            <div>
                                <div id="headlessui-tabs-panel-:r63:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r5v:"
                                     tabindex="0" data-headlessui-state="selected">
                                    <div class="group bg-background">
                                        <div
                                                class="flex h-9 items-center gap-2 border-y border-t-transparent border-purple bg-zinc-900 bg-white/2.5 px-4">
                                            <div class="dark flex"><span
                                                        class="font-mono text-[0.625rem] font-semibold leading-6 text-cyan">GET</span>
                                            </div><span class="h-0.5 w-0.5 rounded-full bg-zinc-500"></span><span
                                                    class="font-mono text-xs text-zinc-400">/v1/posts/:id</span>
                                        </div>
                                        <div class="relative">
                          <pre class="overflow-x-auto p-4 text-xs text-white"><code class="language-bash"><span><span>curl -G https://api.bro.social/v1/posts/:id \</span></span>
                            <span><span>  -H </span><span>"Content-Type: application/json"</span><span> \</span></span>
                          <span></span></code></pre>
                                        </div>
                                    </div>
                                </div><span id="headlessui-tabs-panel-:r64:" role="tabpanel"
                                            aria-labelledby="headlessui-tabs-tab-:r60:" tabindex="-1"
                                            style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span><span
                                        id="headlessui-tabs-panel-:r65:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r61:"
                                        tabindex="-1"
                                        style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span><span
                                        id="headlessui-tabs-panel-:r66:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r62:"
                                        tabindex="-1"
                                        style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span>
                            </div>
                        </div>
                        <div
                                class="not-prose my-6 overflow-hidden rounded-2xl bg-zinc-900 shadow-md bg-background">
                            <div
                                    class="flex min-h-[calc(theme(spacing.12)+1px)] flex-wrap items-start gap-x-4 border-b border-purple px-4">
                                <h3 class="mr-auto pt-3 text-xs font-semibold text-white">Response</h3>
                            </div>
                            <div class="group dark:bg-white/2.5">
                                <div class="relative">
                      <pre class="overflow-x-auto p-4 text-xs text-white">
                        <code class="language-json">
                        <span>{</span>
                        <span>  </span><span class="text-green">"id"</span><span>:</span><span> </span><span class="text-cyan">1</span><span>,</span>
                        <span>  </span><span class="text-green">"userId"</span><span>:</span><span> </span><span class="text-cyan">"elonmusk"</span><span>,</span>
                        <span>  </span><span class="text-green">"date"</span><span>:</span><span> </span><span class="text-cyan">1674421325326</span><span>,</span>
                        <span>  </span><span class="text-green">"title"</span><span>:</span><span> </span><span class="text-cyan">"Este es el titulo del post"</span><span>,</span>
                        <span>  </span><span class="text-green">"text"</span><span>:</span><span> </span><span class="text-cyan">"Esto es el texto del post"</span><span>,</span>
                        <span>  </span><span class="text-green">"image"</span><span>:</span><span> </span><span class="text-cyan">"imagen_02.png"</span><span>,</span>
                        <span>}</span>
                      </code></pre>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <hr>

                <h2 id="the-user-model" class="scroll-mt-24 text-cyan mt-10"><a
                            class="group text-inherit no-underline hover:text-inherit" href="#the-user-model">The
                        user model</a></h2>
                <p class="text-foreground">The USER model contains all the information about your user, such as their username, profile image, and
                    email. It also contains the password already hashed.</p>

                <h3 class="text-xl text-foreground mt-10">USER Properties</h3>
                <div class="my-6">
                    <ul role="list"
                        class="m-0 max-w-[calc(theme(maxWidth.lg)-theme(spacing.8))] list-none divide-y divide-zinc-900/5 p-0 dark:divide-white/5">
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>userId</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">string</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>Unique identifier for the user.</p>
                                </dd>
                            </dl>
                        </li>
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>email</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">string</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>The mail associated with the user.</p>
                                </dd>
                            </dl>
                        </li>
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>displayName</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">string</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>The username that the rest of users will see.</p>
                                </dd>
                            </dl>
                        </li>
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>profilePic</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">string</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>Name of user's profile image.</p>
                                </dd>
                            </dl>
                        </li>
                        <li class="m-0 px-0 py-4 first:pt-0 last:pb-0">
                            <dl class="m-0 flex flex-wrap items-center gap-x-3 gap-y-2">
                                <dt class="sr-only">Name</dt>
                                <dd class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-foreground bg-background text-foreground"><code>passwordHash</code></dd>
                                <dt class="sr-only">Type</dt>
                                <dd class="font-mono text-xs text-cyan">string</dd>
                                <dt class="sr-only">Description</dt>
                                <dd class="w-full flex-none first:mt-0 last:mb-0 text-foreground">
                                    <p>User's account password.</p>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                </div>
                <hr>

                <div class="flex items-center gap-x-3 mt-10"><span
                            class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-cyan bg-comment text-cyan">GET</span><span
                            class="h-0.5 w-0.5 rounded-full bg-zinc-300 dark:bg-zinc-600"></span><span
                            class="font-mono text-xs text-cyan">/v1/users</span></div>
                <h2 id="list-all-users" class="mt-2 scroll-mt-32"><a
                            class="group text-cyan no-underline" href="#list-all-users">List all
                        users</a></h2>
                <div class="grid grid-cols-1 items-start gap-x-16 xl:max-w-none xl:grid-cols-2">
                    <div class="first:mt-0 last:mb-0 text-foreground">
                        <p>This endpoint allows you to retrieve a list of all the users.</p>

                    </div>
                    <div class="first:mt-0 last:mb-0 xl:sticky xl:top-24 text-foreground">
                        <div
                                class="not-prose my-4 overflow-hidden rounded-2xl bg-zinc-900 shadow-md dark:ring-1 dark:ring-white/10">
                            <div
                                    class="flex min-h-[calc(theme(spacing.12)+1px)] flex-wrap items-start gap-x-4 border-b border-purple bg-background px-4">
                                <h3 class="mr-auto pt-3 text-xs font-semibold text-foreground">Request</h3>
                                <div class="-mb-px flex gap-4 text-xs font-medium" role="tablist" aria-orientation="horizontal">
                                    <button
                                            class="border-b py-3 transition focus:[&:not(:focus-visible)]:outline-none border-emerald-500 text-purple"
                                            id="headlessui-tabs-tab-:r67:" role="tab" type="button" aria-selected="true" tabindex="0"
                                            data-headlessui-state="selected"
                                            aria-controls="headlessui-tabs-panel-:r6b:">cURL</button>
                                </div>
                            </div>
                            <div>
                                <div id="headlessui-tabs-panel-:r63:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r5v:"
                                     tabindex="0" data-headlessui-state="selected">
                                    <div class="group bg-background">
                                        <div
                                                class="flex h-9 items-center gap-2 border-y border-t-transparent border-purple bg-zinc-900 bg-white/2.5 px-4">
                                            <div class="dark flex"><span
                                                        class="font-mono text-[0.625rem] font-semibold leading-6 text-cyan">GET</span>
                                            </div><span class="h-0.5 w-0.5 rounded-full bg-zinc-500"></span><span
                                                    class="font-mono text-xs text-zinc-400">/v1/users</span>
                                        </div>
                                        <div class="relative">
                        <pre class="overflow-x-auto p-4 text-xs text-white"><code class="language-bash"><span><span>curl -G https://api.bro.social/v1/users \</span></span>
                          <span><span>  -H </span><span>"Content-Type: application/json"</span><span> \</span></span>
                        <span></span></code></pre>
                                        </div>
                                    </div>
                                </div><span id="headlessui-tabs-panel-:r64:" role="tabpanel"
                                            aria-labelledby="headlessui-tabs-tab-:r60:" tabindex="-1"
                                            style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span><span
                                        id="headlessui-tabs-panel-:r65:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r61:"
                                        tabindex="-1"
                                        style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span><span
                                        id="headlessui-tabs-panel-:r66:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r62:"
                                        tabindex="-1"
                                        style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span>
                            </div>
                        </div>
                        <div
                                class="not-prose my-6 overflow-hidden rounded-2xl shadow-md bg-background">
                            <div
                                    class="flex min-h-[calc(theme(spacing.12)+1px)] flex-wrap items-start gap-x-4 border-b border-purple px-4">
                                <h3 class="mr-auto pt-3 text-xs font-semibold text-white">Response</h3>
                            </div>
                            <div class="group">
                                <div class="relative">
                    <pre class="overflow-x-auto p-4 text-xs text-white">
                      <code class="language-json">
                        <span><span>[</span></span>
                        <span>  </span><span>{</span>
                        <span>    </span><span class="text-green">"userId"</span><span>:</span><span> </span><span class="text-cyan">"elonmusk"</span><span>,</span>
                        <span>    </span><span class="text-green">"email"</span><span>:</span><span> </span><span class="text-cyan">"elonmusk@tesla.com"</span><span>,</span>
                        <span>    </span><span class="text-green">"displayName"</span><span>:</span><span> </span><span class="text-cyan">"Elon Musk"</span><span>,</span>
                        <span>    </span><span class="text-green">"profilePic"</span><span>:</span><span> </span><span class="text-cyan">"elonmuskProfile.png"</span><span>,</span>
                        <span>    </span><span class="text-green">"passwordHash"</span><span>:</span><span> </span><span class="text-cyan">"4111a90d8642585e3c2a90dba0b7e398a73ebed7"</span><span>,</span>
                        <span>  </span><span>},</span>
                        <span>  </span><span>{</span>
                        <span>     </span><span class="text-green">"userId"</span><span>:</span><span> </span><span class="text-cyan">"danubis"</span><span>,</span>
                        <span>     </span><span class="text-currentLine">// ...</span>
                        <span>  </span><span>}</span>
                        <span><span>[</span></span>
                      </code></pre>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="flex items-center gap-x-3 mt-10"><span
                            class="font-mono text-[0.8rem] font-semibold leading-6 rounded-lg px-1.5 ring-1 ring-inset ring-cyan bg-comment text-cyan">GET</span><span
                            class="h-0.5 w-0.5 rounded-full bg-zinc-300 dark:bg-zinc-600"></span><span
                            class="font-mono text-xs text-cyan">/v1/users/:userId</span></div>
                <h2 id="retrieve-a-user" class="mt-2 scroll-mt-32"><a
                            class="group text-cyan no-underline" href="#retrieve-a-user">Retrieve a User</a></h2>
                <div class="grid grid-cols-1 items-start gap-x-16 xl:max-w-none xl:grid-cols-2">
                    <div class="first:mt-0 last:mb-0 text-foreground">
                        <p>This endpoint allows you to retrieve a user by providing their User id.</p>
                    </div>
                    <div class="first:mt-0 last:mb-0 xl:sticky xl:top-24 text-foreground">
                        <div
                                class="not-prose my-4 overflow-hidden rounded-2xl bg-zinc-900 shadow-md dark:ring-1 dark:ring-white/10">
                            <div
                                    class="flex min-h-[calc(theme(spacing.12)+1px)] flex-wrap items-start gap-x-4 border-b border-purple bg-background px-4">
                                <h3 class="mr-auto pt-3 text-xs font-semibold text-foreground">Request</h3>
                                <div class="-mb-px flex gap-4 text-xs font-medium" role="tablist" aria-orientation="horizontal">
                                    <button
                                            class="border-b py-3 transition focus:[&:not(:focus-visible)]:outline-none border-emerald-500 text-purple"
                                            id="headlessui-tabs-tab-:r67:" role="tab" type="button" aria-selected="true" tabindex="0"
                                            data-headlessui-state="selected"
                                            aria-controls="headlessui-tabs-panel-:r6b:">cURL</button>
                                </div>
                            </div>
                            <div>
                                <div id="headlessui-tabs-panel-:r63:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r5v:"
                                     tabindex="0" data-headlessui-state="selected">
                                    <div class="group bg-background">
                                        <div
                                                class="flex h-9 items-center gap-2 border-y border-t-transparent border-purple bg-zinc-900 bg-white/2.5 px-4">
                                            <div class="dark flex"><span
                                                        class="font-mono text-[0.625rem] font-semibold leading-6 text-cyan">GET</span>
                                            </div><span class="h-0.5 w-0.5 rounded-full bg-zinc-500"></span><span
                                                    class="font-mono text-xs text-zinc-400">/v1/users/:userId</span>
                                        </div>
                                        <div class="relative">
                        <pre class="overflow-x-auto p-4 text-xs text-white"><code class="language-bash"><span><span>curl -G https://api.bro.social/v1/users/:userId \</span></span>
                          <span><span>  -H </span><span>"Content-Type: application/json"</span><span> \</span></span>
                        <span></span></code></pre>
                                        </div>
                                    </div>
                                </div><span id="headlessui-tabs-panel-:r64:" role="tabpanel"
                                            aria-labelledby="headlessui-tabs-tab-:r60:" tabindex="-1"
                                            style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span><span
                                        id="headlessui-tabs-panel-:r65:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r61:"
                                        tabindex="-1"
                                        style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span><span
                                        id="headlessui-tabs-panel-:r66:" role="tabpanel" aria-labelledby="headlessui-tabs-tab-:r62:"
                                        tabindex="-1"
                                        style="position: fixed; top: 1px; left: 1px; width: 1px; height: 0px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; border-width: 0px;"></span>
                            </div>
                        </div>
                        <div
                                class="not-prose my-6 overflow-hidden rounded-2xl bg-zinc-900 shadow-md bg-background">
                            <div
                                    class="flex min-h-[calc(theme(spacing.12)+1px)] flex-wrap items-start gap-x-4 border-b border-purple px-4">
                                <h3 class="mr-auto pt-3 text-xs font-semibold text-white">Response</h3>
                            </div>
                            <div class="group dark:bg-white/2.5">
                                <div class="relative">
                    <pre class="overflow-x-auto p-4 text-xs text-white"><code class="language-json">
                      <span>{</span>
                      <span>  </span><span class="text-green">"userId"</span><span>:</span><span> </span><span class="text-cyan">"elonmusk"</span><span>,</span>
                      <span>  </span><span class="text-green">"email"</span><span>:</span><span> </span><span class="text-cyan">"elonmusk@tesla.com"</span><span>,</span>
                      <span>  </span><span class="text-green">"displayName"</span><span>:</span><span> </span><span class="text-cyan">"Elon Musk"</span><span>,</span>
                      <span>  </span><span class="text-green">"profilePic"</span><span>:</span><span> </span><span class="text-cyan">"elonmuskProfile.png"</span><span>,</span>
                      <span>  </span><span class="text-green">"passwordHash"</span><span>:</span><span> </span><span class="text-cyan">"4111a90d8642585e3c2a90dba0b7e398a73ebed7"</span><span>,</span>
                      <span>}</span>
                    </code></pre>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
            </article>
        </main>
    </div>
</@layout.mainLayout>