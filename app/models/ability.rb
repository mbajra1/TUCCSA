class Ability
  include CanCan::Ability


 #define the ability of the user
  def initialize(user)
    user ||= User.new

   # alias_action :create, :read, :update, :destroy, :to => :crud

    if user.is_admin?
      can :manage, :all  # admin can manage all

    else
      # registered can only :update, :destroy the own items
      can [:create, :new, :review, :update, :destroy], CsApplication do |app|
        app.try(:user_id) == user.id
      end
      can [:create, :update, :destroy], MailingAddress do |app|
        app.try(:user_id) == user.id
      end
      can [:create, :update, :destroy], Institution do |app|
       app.try(:user_id) == user.id
      end
      can [:create, :update, :destroy], Rating do |app|
        app.try(:user_id) == user.id
      end
      can [:create, :update, :destroy], Recommendation do |app|
        app.try(:user_id) == user.id
      end

    end
  end
end
