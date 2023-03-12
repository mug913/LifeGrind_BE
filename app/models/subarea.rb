class Subarea < ApplicationRecord
  belongs_to :area
  has_many :records, dependent: :delete_all
end
