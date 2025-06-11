class AddLatitudeAndLongitudeToRestaurants < ActiveRecord::Migration[8.0]
  def change
    add_column :restaurants, :latitude, :float
    add_column :restaurants, :longitude, :float
  end
end
