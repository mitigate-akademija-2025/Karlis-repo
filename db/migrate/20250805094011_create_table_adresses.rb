class CreateTableAdresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.integer :user_id, null: false
      t.string :street
      t.string :city
      t.timestamps
    end
  end
end
