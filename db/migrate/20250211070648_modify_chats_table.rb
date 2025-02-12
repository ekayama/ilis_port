class ModifyChatsTable < ActiveRecord::Migration[6.1]
    def change
      # senders_id を user_id に変更
      rename_column :chats, :senders_id, :user_id
      
      # receiver_id を削除
      remove_column :chats, :receiver_id
    end
  end
  
