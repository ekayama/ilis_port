class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise authentication_keys: [:email] 
  
  validates :email, presence: true, length: { minimum: 2 }
  validates :name, uniqueness: true, length: { maximum: 20 }
end
