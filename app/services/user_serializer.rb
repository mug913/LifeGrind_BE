class UserSerializer
    include JSONAPI::Serializer 

    attributes :id, :username
    has_many :areas
   
 end