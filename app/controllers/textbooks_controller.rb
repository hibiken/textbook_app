class TextbooksController < ApplicationController
  before_action :logged_in_user,  only: [:new, :create, :edit, :update, :destroy]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  def index
    @textbooks = Textbook.includes(:user).order(created_at: :desc)
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
    @textbook = Textbook.find(params[:id])
  end

  def update
    @textbook = Textbook.find(params[:id])
    if @textbook.update_attributes(textbook_params)
      flash[:success] = "Your listing has been updated"
      redirect_to @textbook.user
    else
      render :edit
    end
  end

  def destroy
    textbook = Textbook.find(params[:id]).destroy
    flash[:success] = "'#{textbook.title}' has been taken off of your listing"
    redirect_to textbook.user
  end

  private

    def textbook_params
      params.require(:textbook).permit(:title, :price)
    end

    # Confirms the owner of the textbook
    def authorized_user
      @textbook = Textbook.find(params[:id])      
      redirect_to root_url unless current_user?(@textbook.user)
    end

end
