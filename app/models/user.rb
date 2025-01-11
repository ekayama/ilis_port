class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, length: { minimum: 2 }
  validates :username, uniqueness: true, length: { maximum: 20 }

  has_many :posts, dependent: :destroy
  has_one_attached :profile_image

  def get_profile_image(height, width)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images3/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [height, width]).processed
  end
  
 
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(username: content)
    elsif method == 'forward'
      User.where('username LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('username LIKE ?', '%' + content)
    else
      User.where('username LIKE ?', '%' + content + '%')
    end
  end
end
