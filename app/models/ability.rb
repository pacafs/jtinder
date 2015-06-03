class Ability
  include CanCan::Ability

  def initialize(user)

        can :read, :all

        can :update, User do |u|
            u == user
        end

  end
end

