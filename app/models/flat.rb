class Flat < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :title, presence: true
  validates :location, presence: true

  has_many :bookings, dependent: :destroy
end
