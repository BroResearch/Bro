<#import "template.ftl" as layout />

<@layout.mainLayout title="New post">
    <div>
        <div class="md:grid md:gap-6">
            <div class="mt-5 md:mt-0">
                <form action="/post-new" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="date" value="${date?c}">
                    <input type="hidden" name="code" value="${code}">
                    <div class="shadow-2xl sm:overflow-hidden sm:rounded-md">
                        <div class="space-y-6 px-4 py-5 sm:p-6">
                            <div class="grid grid-cols-3 gap-6">
                                <div class="col-span-6 sm:col-span-3">
                                    <label for="title" class="block text-sm font-medium underline decoration-purple text-foreground">Title</label>
                                    <input type="text" name="title" id="title" autocomplete="given-name" class="mt-1 block w-full rounded-md shadow-sm focus:border-purple focus:ring-purple sm:text-sm" placeholder="My Title">
                                </div>
                            </div>

                            <div>
                                <label for="post-text" class="block text-sm font-medium underline decoration-purple text-foreground">Body</label>
                                <div class="mt-1">
                                    <textarea id="post-text" name="text" rows="3" class="mt-1 block w-full rounded-md shadow-sm focus:border-purple focus:ring-purple sm:text-sm" placeholder="My Body"></textarea>
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-pink">Photo</label>
                                <div class="mt-1 flex justify-center rounded-md border-2 border-dashed border-pink px-6 pt-5 pb-6">
                                    <div class="space-y-1 text-center">
                                        <svg class="mx-auto h-12 w-12 text-purple" stroke="currentColor" fill="none" viewBox="0 0 48 48" aria-hidden="true">
                                            <path d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                                        </svg>
                                        <div class="flex text-sm text-foreground">
                                            <label for="file-upload" class="relative cursor-pointer rounded-md bg-purple font-medium text-indigo-600 focus-within:outline-none focus-within:ring-2 focus-within:ring-indigo-500 focus-within:ring-offset-2 hover:text-indigo-500">
                                                <span>Upload a file</span>
                                                <input name="file-upload" type="file" accept="image/png, image/jpeg" required>
                                            </label>
                                            <p class="pl-1">or drag and drop</p>
                                        </div>
                                        <p class="text-xs text-foreground">PNG, JPG, GIF up to 10MB</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="bg-gray-50 px-4 py-3 text-right sm:px-6">
                            <button value="Post" type="submit" class="inline-flex justify-center rounded-md border border-transparent bg-cyan py-2 px-4 text-sm font-medium text-background shadow-sm hover:bg-comment focus:outline-none focus:ring-2 focus:ring-comment focus:ring-offset-2">Save</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

</@layout.mainLayout>