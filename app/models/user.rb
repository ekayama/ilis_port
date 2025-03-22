class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  scope :active_users, -> { where(status: 1, is_deleted: false) }
        
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image
  #has_many :posts, through: :favorites
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  enum status:{nonreleased: 0, released: 1}

  # 自分がフォローされる側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
    
  # 自分がフォローする側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed



  validates :email, uniqueness: true, presence: true, length: { minimum: 2 }
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :profile_description, length: { maximum: 50 }

    # 退会済みのユーザーはログイン不可
    def active_for_authentication?
      super && !is_deleted
    end
  
  def get_profile_image(height, width)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images3/no_image.jpg')
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


  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
