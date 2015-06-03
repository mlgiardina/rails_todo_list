class AddLimitToTodoBody < ActiveRecord::Migration
  def change
    change_column(:todos, :body, :string, limit: 300)
  end
end
