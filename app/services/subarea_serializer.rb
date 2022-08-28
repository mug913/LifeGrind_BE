class SubareaSerializer
    include JSONAPI::Serializer

    attributes :id, :name, :position, :streak, :level, :area_id, :details
    has_many :records, serializer: :Record
    set_type :subarea
end