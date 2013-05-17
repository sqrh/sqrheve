class Climate
  include MongoMapper::Document
  key :name, String
  key :cls, Integer
  key :affects, Array

end
