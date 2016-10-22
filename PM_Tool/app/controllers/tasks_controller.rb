class TasksController < ApplicationController
  def create
    @project = Project.find params[:project_id]
    task_params = params.require(:task).permit([:title, :body, :due_date])
    @task = Task.new task_params
    @task.project = @project
     if @task.save
       redirect_to project_path(@project)
     else
       render 'projects/show'
     end
  end

  def edit
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
  end

  def update
    @project = Project.find params[:project_id]
    @task = Task.find params[:id]
    task_params = params.require(:discussion).permit(:title, :body, :due_date)
    if @task.update task_params
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    project = Project.find params[:project_id]
    task = Task.find params[:id]
    task.destroy
    redirect_to project_path(project)
  end
end
