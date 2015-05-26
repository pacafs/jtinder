class MatchesController < ApplicationController
  
  before_action :require_login
  before_action :set_match, only:[:get_email]

  def index
  	@matches = current_user.friendships.where(state: "ACTIVE").map(&:friend) + current_user.inverse_friendships.where(state: "ACTIVE").map(&:user)
  end

  def get_email
  	respond_to do |format|
      format.js
    end
  end


  private

  def set_match
  	@match = User.find(params[:id])
  end

end

