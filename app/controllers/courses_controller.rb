class CoursesController < ApplicationController
  before_action :logged_in_user

  def index
    @courses = current_user.courses
  end

  def show
  end

  def new
  end

  def create
    course = Course.find(params[:user][:course_id])
    if current_user.courses << course
      flash[:success] = "You have requested a textbook for #{course.name}"
      redirect_to wishlist_url
    else
      flash[:danger] = "Sorry, something went wrong. Please try again"
      render :new
    end
  end

  def destroy
    course = Course.find(params[:id])
    current_user.courses.delete(course)
    flash[:success] = "Deleted #{course.name} from your wishlist"
    redirect_to wishlist_url
  end

end
