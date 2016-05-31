class AddAttachmentsToUserFiles < ActiveRecord::Migration
  def up
    add_attachment :user_files, :media
  end

  def down
    remove_attachment :user_files, :media
  end
end
