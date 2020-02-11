class SearchController < ApplicationController
  def search
    method = params[:search_method]
    word = params[:search_word]
    content = params[:search_content]
    
    if content == ["book"]
      @contents = Book.search(method,word)
    elsif content == ["user"]
      @contents = User.search(method,word)
    end
  end
end
