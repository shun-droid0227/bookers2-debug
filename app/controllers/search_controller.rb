class SearchController < ApplicationController
  def search
    method = params[:search_method]
    word = params[:search_word]
    @search_content = params[:search_content]
    if @search_content == "book"
      @contents = Book.search(method,word)
    elsif @search_content == "user"
      @contents = User.search(method,word)
    end
  end
  #検索が/のせいで連続で行えない　なぜパラメーターに[]がつくのか
end
