class Ability
  include CanCan::Ability

  #CnanCanCan will automatically instanciate an ability object with every request. it will just expect that you have a method in your controller named current_user, which we do.

  def initialize(user)

    #It's hardly recommended that you start with this line because user will ne nill if the user is not signed in.
    # it would be nice to have user variable to a new object if its nil so we can easily compare.

    user ||= User.new

    # :manage refers to doing any action on the question object: :read, :edit, :delete, :update...
    can :manage, Question do |q|
      q.user == user
    end

    cannot :like, Question do |q|
      q.user == user
    end

    can :like, Question do |q|
      user != q.user
    end

    can :delete, Answer do |a|
      a.user == user || a.question.user == user
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
      if user.admin?
        can :manage, :all
      else
        can :read, :all
      end

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
