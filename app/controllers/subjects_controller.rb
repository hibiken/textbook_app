class SubjectsController < ApplicationController
  def show
    @subject   = Subject.find(params[:id])
    @textbooks = @subject.textbooks
  end
end
