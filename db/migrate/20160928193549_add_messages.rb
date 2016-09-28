class AddMessages < ActiveRecord::Migration
  def change
    create_table :takeoffs do |t|
      t.string :email
      t.string :subject
      t.string :content
      t.string :file_url
    end
  end
end
