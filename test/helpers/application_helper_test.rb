require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "#cover_art_header should display the given cover art, title and description" do
    rendered_html = cover_art_header(
      cover_art_url: "http://example.com/cover_art.png",
      title: "Example Podcast",
      description: "This is an example podcast."
    )

    assert_dom_equal <<~HTML, rendered_html
      <div class="flex flex-col gap-y-3 justify-stretch items-stretch sm:flex-row sm:gap-x-4">
        <div class="inline-block grow-0 shrink-0 basis-full sm:basis-1/5 lg:basis-44">
          <img class="rounded shadow w-full aspect-1" src="http://example.com/cover_art.png">
        </div>
        <div class="inline-block basis-full sm:basis-4/5 md:basis-4/5 lg:basis-full">
          <h1 class="text-3xl font-bold mb-2">Example Podcast</h1>
          <div class="text-gray-500">This is an example podcast.</div>
        </div>
      </div>
    HTML
  end

  test "#cover_art_header raises an error if title or cover_art_url are missing" do
    assert_raises KeyError do
      cover_art_header(cover_art_url: "http://example.com/cover_art.png")
    end

    assert_raises KeyError do
      cover_art_header(title: "Example Podcast")
    end
  end
end
