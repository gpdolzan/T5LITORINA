class CreateDisciplinesUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :disciplines_users, id: false do |t|
      t.references :discipline, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
    
    add_index :disciplines_users, [:discipline_id, :user_id], unique: true
  end
end
