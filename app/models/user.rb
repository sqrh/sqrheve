class User
  include MongoMapper::Document

  key :email, String
  key :name, String

end
