class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true, length:{maximum:400}
  validates :body, presence: true
  # validates :image, presence: true

  scope :active_posts, -> { joins(:user).where(user:  {status: 1, is_deleted: false}) }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def get_image(height, width)
    if images.attached?
      images.first.variant(resize_to_limit: [height, width]).processed # 最初の1枚を取得
    else
      file_path = Rails.root.join('app/assets/images3/no_image.jpg') # デフォルト画像
      ActiveStorage::Blob.create_and_upload!(
        io: File.open(file_path),
        filename: 'no_image.jpg',
        content_type: 'image/jpeg'
      ).variant(resize_to_limit: [height, width]).processed
    end
  end

  def get_images(height, width)
    return_images = []
    if images.attached?
      images.each do |image|
        return_images << image.variant(resize_to_limit: [height, width]).processed # 最初の1枚を取得
      end
    else
      file_path = Rails.root.join('app/assets/images3/no_image.jpg') # デフォルト画像
      image = ActiveStorage::Blob.create_and_upload!(
        io: File.open(file_path),
        filename: 'no_image.jpg',
        content_type: 'image/jpeg'
      ).variant(resize_to_limit: [height, width]).processed
      return_images << image
    end
    return_images
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
