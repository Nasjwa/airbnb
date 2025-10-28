class Flat < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  validates :title, presence: true
  validates :location, presence: true

  has_many :bookings, dependent: :destroy
end
