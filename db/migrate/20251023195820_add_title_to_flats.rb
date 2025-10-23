class AddTitleToFlats < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :title, :string
  end
end
