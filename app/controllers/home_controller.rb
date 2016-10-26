class HomeController < ApplicationController

  # this method is called action
  def index
    # This will renders views/home/index.html.erb and it will use views/layouts/applicatin.html.erb
    # render :index, layout: "application" # This line is optional, no need to do it!
    cookies[:last_visited] = Time.now
    cookies[:lucky_number] = rand(100)
  end

  def contact
  end

  def contact_submit
    @name = params[:full_name]
  end

  def faq
  end


end
