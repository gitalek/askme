class ChangeColumnInQuestions < ActiveRecord::Migration[5.1]
  def change
    rename_column :questions, :ansnwer, :answer
  end
end
