class Comment
  include MongoMapper::Document
  key :body, String
  timestamps!

  belongs_to :commentable, :polymorphic => true

end
