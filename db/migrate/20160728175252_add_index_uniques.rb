class AddIndexUniques < ActiveRecord::Migration
  def change
    remove_index :users, :user_name
    add_index :users, :user_name, unique: true
    add_index :polls, :title, unique: true
  end
end
