class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :book_comments, dependent: :destroy


  has_many :followers, class_name: 'Relationship',
                        foreign_key: 'follower_id',
                        dependent: :destroy

  has_many :followings, class_name: 'Relationship',
                        foreign_key: 'followed_id',
                        dependent: :destroy



  def follow(user_id)
    # self.followers.create(followed_id: user_id)
    unless self.id == user_id.to_i
      relationship = Relationship.new(follower_id: self.id, followed_id: user_id.to_i)
      relationship.save
    end
  end

  def unfollow(user_id)
    unless self.id == user_id.to_i
      relationships = Relationship.find_by(follower_id: self.id, followed_id: user_id.to_i)
      relationships.destroy if relationships
    end
  end

  # 今フォローしているか確認する
  def following?(user)
    # self.following_users.include?(user)
    Relationship.exists?(follower_id: self.id, followed_id: user.id)
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true

  validates :introduction, length: { maximum: 50 }
  
  
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  
end
