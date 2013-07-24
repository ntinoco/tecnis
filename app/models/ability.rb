class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new # guest user
 
    if user.role? "admin"
      can :manage, :all
    else
      # Implementar aquí cualquier otro rol que pueda hacer cosas:
      can :read, Product, User
    end
  end
end