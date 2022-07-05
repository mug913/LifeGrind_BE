class Subarea < ApplicationRecord
  belongs_to :area
  has_many :records, dependent: :destroy
end
