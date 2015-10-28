class SubjectsController < ApplicationController
  def show
    @subject   = Subject.friendly.find(params[:id])
    @textbooks = @subject.textbooks.paginate(page: params[:page])
  end
end
