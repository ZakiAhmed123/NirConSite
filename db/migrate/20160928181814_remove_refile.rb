class RemoveRefile < ActiveRecord::Migration
  def change
    drop_table :refile_attachments
  end
end
