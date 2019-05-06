class AddImageToSong < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :image, :text
  end
end
