class CommentsController < ApplicationController
  def new
    @comment = comment.new
  end

  def create
    comment_params = params.require(:comment).permit([:body])
    @comment = comment.new comment_params
     if @comment.save
       redirect_to comment_path(@comment)
     else
       render :new
     end
  end

  def show
    @comment = comment.find params[:id]
  end

  def index
    @comments = comment.order(created_at: :desc)
  end

  def edit
    @comment = comment.find params[:id]
  end

  def update

    @comment = comment.find params[:id]
    comment_params = params.require(:comment).permit(:body)
    if @comment.update comment_params
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    @comment = comment.find params[:id]
    @comment.destroy
    redirect_to comments_path
  end
end

end
