class BooksController < ApplicationController
    before_action :authenticate_author!
    def index
        @books = Book.all
        respond_to do |format|
          format.html
          format.xlsx do
            response.headers['Content-Disposition'] = 'attachment; filename="books.xlsx"'
            render xlsx: 'index', filename: 'books.xlsx'
          end
          format.csv do
            response.headers['Content-Disposition'] = 'attachment; filename="books.csv"'
            render csv: 'index', filename: 'books.csv'
          end
        end
    end

    def show
        @book = Book.find(params[:id])
        render :show
    end

    def new
        @book = Book.new
    end

    def create
        @book = Book.new(book_params)

        if @book.save
            redirect_to @book
        else
            flash[:error] = "Book name must be unique."
            render :new

        end
    end

    def edit
        @book = Book.find(params[:id])
        render :edit
    end

    def update
        @book = Book.find(params[:id])

        if @book.update(book_params)
            redirect_to @book
        else
            render :edit
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy

        redirect_to books_path
    end

    private

    def book_params
        params.require(:book).permit(:name, :release_date, :author_id)
    end
end
