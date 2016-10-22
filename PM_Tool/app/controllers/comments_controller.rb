class CommentsController < ApplicationController
  def create
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:discussion_id]
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @comment.discussion = @discussion
    if @comment.save
      redirect_to project_discussion_path(@project, @discussion), notice: 'Comment Created!'
    else
      render 'discussions/show'
    end
  end

  def edit
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:discussion_id]
    @comment = Comment.find params[:id]
  end

  def update
    @project = Project.find params[:project_id]
    @discussion = Discussion.find params[:discussion_id]
    @comment = Comment.find params[:id]
    comment_params = params.require(:comment).permit(:body)
    if @comment.update(comment_params)
      redirect_to project_discussion_path(@project, @discussion)
    else
      render :edit
    end
  end


  def destroy
    project = Project.find params[:project_id]
    discussion = Discussion.find params[:discussion_id]
    comment = Comment.find params[:id]
    comment.destroy

    redirect_to project_discussion_path(project, discussion), notice: "Comment deleted!"
  end
end
