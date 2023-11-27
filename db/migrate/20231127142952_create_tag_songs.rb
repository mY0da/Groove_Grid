class CreateTagSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :tag_songs do |t|
      t.references :song, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
