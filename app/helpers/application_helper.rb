module ApplicationHelper
  def cover_art_header(**options, &block)
    content_tag(:div, class: "flex flex-col gap-y-3 justify-stretch items-stretch sm:flex-row sm:gap-x-4") do
      content_tag(:div, class: "inline-block grow-0 shrink-0 basis-full sm:basis-1/5 lg:basis-44") do
        image_tag(options.fetch(:cover_art_url), class: "rounded shadow w-full h-auto")
      end +
      content_tag(:div, class: "inline-block basis-full sm:basis-4/5 md:basis-4/5 lg:basis-full") do
        content_tag(:h1, class: "text-3xl font-bold mb-2") { options.fetch(:title) } +
        content_tag(:div, class: "text-gray-500") { options.fetch(:description, block&.call || "") }
      end
    end
  end
end
