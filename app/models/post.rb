class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true, length:{maximum:400}
  validates :body, presence: true
  validates :image, presence: true

  scope :active_posts, -> { joins(:user).where(user:  {status: 1, is_deleted: false}) }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def get_image(height, width)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images3/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [height, width]).processed
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where(title: content)
      # ここだけエラーが起きて実装できず。。
    elsif method == 'forward'
      Post.where('title or body LIKE ?', content+'%')
    elsif method == 'backward'
      Post.where('title or body LIKE ?', '%'+content)
    else
      Post.where('title or body LIKE ?', '%'+content+'%')
    end
  end
end
