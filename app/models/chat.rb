class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :chat_content, presence: true, length: { maximum: 300 }
end
