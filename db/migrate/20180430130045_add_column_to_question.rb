class AddColumnToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :questioner_id, :string
  end
end
