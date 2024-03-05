class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #belongs_to :books
  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # フォロー機能
  # アソシエーションの仕組み
  # 中間テーブルと結ぶ（中間テーブルの中身は"Relationship"モデルの"follower_id"キー）
  # 架空テーブルと結び、そこから中間テーブルを介して、userのテーブルであるfollowerと繋げる
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :follower_tables, through: :follower_relationships, source: :follower

  has_many :followed_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_tables, through: :followed_relationships, source: :followed

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  # フォロー機能関連メソッド
  def follow(user)
    follower_relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    follower_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followed_tables.include?(user)
  end

  # プロフィール画像を取得するメソッド
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
#    unless profile_image.attached?
#      file_path = Rails.root.join('app/assets/images/no_image.jpg')
#      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
#    end
  end

end
