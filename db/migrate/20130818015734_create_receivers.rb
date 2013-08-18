class CreateReceivers < ActiveRecord::Migration
  def change
    create_table :receivers do |t|
      t.references :message
      t.references :user

      t.timestamps
    end
    add_index :receivers, :message_id
    add_index :receivers, :user_id
  end
end
