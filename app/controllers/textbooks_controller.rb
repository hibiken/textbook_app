class TextbooksController < ApplicationController
  def index
  end

  def show
  end

  def new
    @textbook = current_user.textbooks.build
  end

  def create
    @textbook = current_user.textbooks.build(textbook_params)
    if @textbook.save
      flash[:success] = "Successfully created a new listing"
      redirect_to @current_user
    else
      render :new
    end
  end

  def edit
  end

  private

    def textbook_params
      params.require(:textbook).permit(:title, :price)
    end

end
