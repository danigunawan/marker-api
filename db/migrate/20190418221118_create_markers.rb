class CreateMarkers < ActiveRecord::Migration[5.2]
  def change
    create_table :markers do |t|
      t.decimal :lat
      t.decimal :long
      # t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
