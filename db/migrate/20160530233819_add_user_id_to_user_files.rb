class AddUserIdToUserFiles < ActiveRecord::Migration
  def change
    add_column :user_files, :user_id, :integer
  end
end
