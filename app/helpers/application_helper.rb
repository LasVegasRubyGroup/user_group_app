module ApplicationHelper

  def markdown
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(safe_links_only: true, hard_wrap: true, filter_html: true), autolink: true, strikethrough: true)
  end

end
