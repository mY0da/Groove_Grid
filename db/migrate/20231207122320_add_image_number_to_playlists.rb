class AddImageNumberToPlaylists < ActiveRecord::Migration[7.1]
  def change
    add_column :playlists, :image_number, :integer
  end
end
