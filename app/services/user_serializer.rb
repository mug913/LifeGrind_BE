class UserSerializer
    include JSONAPI::Serializer 

    attributes :id, :username,:areas
    has_many :areas
   
 end