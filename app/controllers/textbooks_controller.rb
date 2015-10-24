class TextbooksController < ApplicationController
  layout :set_layout

  before_action :logged_in_user,  only: [:new, :create, :edit, :update, :destroy, :sold]
  before_action :authorized_user, only: [:edit, :update, :destroy, :sold]
  after_action  :notify_users,    only: [:create]

  def index
    if params[:search]
      @textbooks = Textbook.includes(:user).search(params[:search])
    else
      @textbooks = Textbook.includes(:user).where(sold: false)
    end
  end

  def show
    @textbook = Textbook.includes(:user, :comments).friendly.find(params[:id])
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

  def update
    if @textbook.update_attributes(textbook_params)
      flash[:success] = "Your listing has been updated"
      redirect_to @textbook.user
    else
      render :edit
    end
  end

  def destroy
    @textbook.destroy
    flash[:success] = "'#{@textbook.title}' has been taken off of your listing"
    redirect_to @textbook.user
  end

  def sold
    if @textbook.update_attribute(:sold, true)
      flash[:success] = "Marked #{@textbook.title} as sold!"
      redirect_to @textbook.user
    else
      flash[:danger] = "Something went wrong. Please try agian"
      redirect_to @textbook.user
    end
  end

  private

    def textbook_params
      params.require(:textbook).permit(:title, :price, :description, :subject_id, :course_id, :image)
    end

    # Confirms the owner of the textbook
    def authorized_user
      @textbook = Textbook.friendly.find(params[:id])      
      redirect_to root_url unless current_user?(@textbook.user)
    end

    def notify_users
      # TODO: check if this is correct way to deal with course_id being nil
      return if @textbook.course_id.nil?
    
      course = Course.find(@textbook.course_id)
      message = "#{current_user.name} is selling a book for #{course.name}"
      # Use find_each to do batch processing, instead of loading all the data in memory
      course.users.find_each do |user| 
        Notification.create(user_id: user.id, message: message, path: textbook_path(@textbook))
      end
    end

    # Sets the layout for textbooks views depending on the action.
    def set_layout
      case action_name
      when 'new', 'edit'
        'static_pages'
      else
        'application'
      end
    end

end

















