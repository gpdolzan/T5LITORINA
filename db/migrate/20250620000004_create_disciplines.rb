class CreateDisciplines < ActiveRecord::Migration[7.0]
  def change
    create_table :disciplines do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.text :description
      t.integer :credits
      t.references :professor, null: false, foreign_key: true

      t.timestamps
    end
    add_index :disciplines, :code, unique: true
  end
end
