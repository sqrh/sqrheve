class Info
  include MongoMapper::Document

  many :comments, :as => :commentable
  key :name, String
  key :content, String
  timestamps!

  def rc
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
    markdown.render(content)
  end

end
