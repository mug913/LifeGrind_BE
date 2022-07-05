class Area < ApplicationRecord
  belongs_to :user
  has_many :subareas, dependent: :destroy
end
