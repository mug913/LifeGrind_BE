class AreaSerializer
    include JSONAPI::Serializer 
    attributes :id, :name, :position, :streak, :level, :user_id
    has_many :subareas

end