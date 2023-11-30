class CreateTagsProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :tags_profiles do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
