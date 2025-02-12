class ChangeChatContentToMessageInChats < ActiveRecord::Migration[6.1]
    def change
      # chat_content を message にリネーム
      rename_column :chats, :chat_content, :message
      
      # message カラムのデータ型を text から string に変更
      change_column :chats, :message, :string
    end
end
