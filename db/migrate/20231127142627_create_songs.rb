class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :name, null: false
      t.integer :seconds
      t.integer :bpm
      t.string :scale
      t.references :user, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end
  end
end
