class BookController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :set_book, only: [:show, :edit, :update] 

    def new 
        @book = Book.new  
        @book.build_genre 
    end 

    def create
        @book = Book.new(book_params) 
        @book.user_id = session[:user_id] 
   
       if @book.save 
         redirect_to book_path(@book) 
       else
        @book.build_genre  
         render :new 
       end
     end

    def index   
      if params[:genre_id]
        genre = Genre.find(params[:genre_id])
        @books = genre.books 
      
      else 
        @books = Book.order_by_rating.includes(:genre) 
      end 
    end 

    def show 
    end 

    def edit 
      if authorized_to_edit?(@book) 
       render :edit   
      else 
       redirect_to book_path(@book)   
      end
     end 

    def update   
      if @book.update(book_params)
        redirect_to book_path(@book)
      else
        render :edit
      end 
    end 

    def most_popular 
      @books = Book.most_popular 
    end 

    private 

    def book_params
        params.require(:book).permit(:name, :price_range, :address, :genre_id, genre_attributes: [:name])
      end

    def set_book
        @book = Book.find_by(id: params[:id])
        redirect_to books_path if !@book 
     end

     def redirect_if_not_authorized 
      if @book.update(name: params[:name], price_range: params[:price_range], address: params[:address])   
        redirect_to book_path(@book)
      else
        redirect_to user_path(current_user)     
      end 
    end

end