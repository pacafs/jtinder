class MatchesController < ApplicationController
  
  before_action :require_login

  def index
  	@matches = current_user.friendships.where(state: "ACTIVE").map(&:friend) + current_user.inverse_friendships.where(state: "ACTIVE").map(&:user)
  end

end


