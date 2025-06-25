class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :number, null: false
      t.string :building
      t.integer :capacity
      t.references :professor, foreign_key: true

      t.timestamps
    end
    add_index :rooms, :number, unique: true
  end
end
