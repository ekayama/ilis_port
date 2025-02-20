class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer	:user_id
      t.text	:message
      t.integer	:room_id
      t.boolean	:read_flag, null: false, default: false
      t.timestamps
    end
  end
end
