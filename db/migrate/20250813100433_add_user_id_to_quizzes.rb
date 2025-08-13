class AddUserIdToQuizzes < ActiveRecord::Migration[8.0]
  def change
    add_column :quizzes, :user_id, :integer
  end
end
