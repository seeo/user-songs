class AddHoursToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :hours, :datetime, :null=> true
    #used datetime instead of just time data type because I need hours column to be timezone aware
  end
end
