class Flat < ApplicationRecord
  belongs_to :user
  has_many_attached :photos

  validates :title, presence: true
  validates :location, presence: true

  has_many :bookings, dependent: :destroy

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

end
