class DiscussionsController < ApplicationController
  def create
    @project = Project.find params[:project_id]
    discussion_params = params.require(:discussion).permit(:title, :body)
    @discussion = Discussion.new discussion_params
    @discussion.project = @project
    if @discussion.save
      redirect_to project_path(@project), notice: 'Discussion created!'
      @comment = Comment.new
    else
      render 'projects/show'
    end
  end

  def show
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:id]
    @comment = Comment.new
  end

  def edit
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:id]
  end

  def update
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:id]
    discussion_params = params.require(:discussion).permit(:title, :body)
    if @discussion.update(discussion_params)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    project = Project.find params[:project_id]
    discussion = Discussion.find params[:id]
    discussion.destroy
    redirect_to project_path(project), notice: 'Discussion Deleted!'
  end
end
