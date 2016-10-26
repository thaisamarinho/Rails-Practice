class QuestionsController < ApplicationController

  # the before ation method here registrer a method usually private to be executed just before controller actions. This happens within the same request/response cycle which means if you define an instance variable it will be available within the action
  # You can optionally give options: "only" or "except" to restrict the actions that 'before_action' method applies to.

  before_action :authenticate_user, except: [:index, :show]
  before_action :find_question, only: [:edit, :update, :destroy, :show]
  #the before_action method will be executed at order that the they get defined with. This means the authenticate_user will be called before the authorize_access method. This means that the user will be inside authenticated when we're inside the authenticate_user method so we dont have o check for that.
  before_action :authorize_access, only: [:edit, :update, :destroy]

  # This action is to show the form for creating a new question
  # the URL: /questions/new
  # the path helper will be: new_question_path
  def new
    @question = Question.new
  end

  # this action is to handle creating a new question after submitting the form
  # that was shown in the new action
  def create
    @question = Question.new question_params
    @question.user = current_user
     if @question.save
       flash[:notice] = 'Question Created!'
       redirect_to question_path(@question)
     else
       flash.now[:alert] = 'Please see errors below'
       render :new
     end
  end

  # this action is to show information about a specific question
    # URL: /questions/:id (for example /questions/123)
    # METHOD: GET
  def show
    @answer = Answer.new
  end

  # this action is to show a listings of all the questions
   # URL: /questions
   # METHOD: GET
  def index
    @questions = Question.order(created_at: :desc)
  end

  # this action is to show a form pre-populated with the question's data
# URL: /questions/:id/edit
# METHOD: GET
  def edit
  end

  # this action is to capture the parameters from the form submission form the
  # edit action in order to update a question
  # URL: /questions/:id
  # Method: path
  def update
    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Question Deleted'
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def find_question
    @question = Question.find params[:id]
  end

  def authorize_access
    unless can? :manage, @question
      # unless (current_user == @question.user || current_user.admin?)
      # head :unauthorized # this will send a 401 response
      redirect_to root_path, alert: 'Access Denied'
  end
end



end
