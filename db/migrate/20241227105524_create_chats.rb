class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer	:senders_id
      t.integer	:receiver_id
      t.text	:chat_content
      t.integer	:room_id
      t.boolean	:read_flag, null: false, default: false
      t.timestamps
    end
  end
end
