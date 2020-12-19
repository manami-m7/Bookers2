class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # フォロー取得
  has_many :followed_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  #フォロワー取得
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 自分がフォローしている人
  has_many :followings, through: :followed_relationships, source: :followed

  # 自分をフォローしている人 される
  has_many :followers, through: :follower_relationships, source: :follower

  #ユーザーをフォローする
  def follow(other_user)
    followed_relationships.create(followed_id: other_user.id)
  end

  #ユーザーのフォローを外す
  def unfollow(other_user)
    followed_relationships.find_by(followed_id: other_user.id).destroy
  end

  #フォローしていればtrueを返す
  def following?(other_user)
    followed_relationships.include?(followed_id: other_user.id)
  end

  attachment :profile_image

  validates :name, uniqueness: true
  validates :name, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
end
