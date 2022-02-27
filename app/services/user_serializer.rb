class UserSerializer
    include JSONAPI::Serializer
  
    attributes :id, :username
    
    has_many :areas, serializer: :area
    # has_many :subareas, through: :areas
end