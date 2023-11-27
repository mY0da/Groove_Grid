class CreateLabels < ActiveRecord::Migration[7.1]
  def change
    create_table :labels do |t|
      t.string :name

      t.timestamps
    end
  end
end
