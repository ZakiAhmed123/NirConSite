class CreateStabilizers < ActiveRecord::Migration
  def change
    create_table :stabilizers do |t|

      t.timestamps null: false
    end
  end
end
