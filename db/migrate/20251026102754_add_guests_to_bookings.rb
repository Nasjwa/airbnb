class AddGuestsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :guests, :integer
  end
end
