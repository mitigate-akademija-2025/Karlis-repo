class CreateUserAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :user_answers do |t|
      t.references :quiz_attempt, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :answer
      t.boolean :correct

      t.timestamps
    end
  end
end
