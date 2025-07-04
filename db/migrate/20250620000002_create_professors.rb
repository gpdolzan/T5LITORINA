class CreateProfessors < ActiveRecord::Migration[7.0]
  def change
    create_table :professors do |t|
      t.string :name, null: false
      t.string :specialization, null: false
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
