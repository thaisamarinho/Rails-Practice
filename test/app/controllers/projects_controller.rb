class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    project_params = params.require(:project).permit([:title, :description, :due_date])
    @project = Project.new project_params
     if @project.save
       redirect_to project_path(@project)
     else
       render :new
     end
  end

  def show
    @project = Project.find params[:id]
  end

  def index
    @projects = Project.order(title: :desc)
  end

  def edit
    @project = Project.find params[:id]
  end

  def update

    @project = Project.find params[:id]
    project_params = params.require(:project).permit(:title, :description)
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find params[:id]
    @project.destroy
    redirect_to projects_path
  end
end
