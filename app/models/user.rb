class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable
  #test
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :relationships
  #         /架空のモデル /中間テーブルはrelationships/relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセス
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  attachment :profile_image, destroy: false
  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}


  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  #検索メソッド 
  def self.search(method,word)
    if method == ["forward_match"]
      @contents = User.where("name LIKE(?)","#{word}%")
    elsif method == ["backward_match"]
      @contents = User.where("name LIKE(?)","%#{word}")
    elsif method == ["perfect_match"]
      @contents = User.where("#{word}")
    elsif method == ["partial_match"]
      @contents = User.where("name LIKE(?)","%#{word}%")
    else
      @contents = User.all
    end
end

end
