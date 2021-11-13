class Subarea < ApplicationRecord
  belongs_to :area
  has_many :records
end
