class RecordSerializer
    include JSONAPI::Serializer 

    attributes :id, :date, :subarea_id,
    :detail_1_type,
    :detail_1_data,
    :detail_2_type,
    :detail_2_data,
    :detail_3_type,
    :detail_3_data
end