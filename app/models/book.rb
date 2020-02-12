class Book < ApplicationRecord

	belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	#検索メソッド 
  def self.search(method,word)
    if method == "forward_match"
        @contents = Book.where("title LIKE(?)","#{word}%")
    elsif method == "backward_match"
        @contents = Book.where("title LIKE(?)","%#{word}")
    elsif method == "perfect_match"
        @contents = Book.where("#{word}")
    elsif method == "partial_match"
        @contents = Book.where("title LIKE(?)","%#{word}%")
    else
        @contents = Book.all
    end
end

end
