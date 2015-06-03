class FriendshipsController < ApplicationController

	before_action :require_login
	before_action :set_friend

	def create
		
		@inverse_friendship = current_user.inverse_friendships.where(user_id: @friend.id)
		
		unless @inverse_friendship.blank?
			@friend.accept_match(current_user)
			@friend.save
			@match = true
		else
			@friendship = current_user.request_match(@friend)
		end

		respond_to do |format|
			format.js
		end

	end

	def destroy
		
		@friendship = current_user.remove_match(@friend)

		respond_to do |format|
			format.html {redirect_to users_path}
		end

	end


    

	private

	def set_friend
		@friend = User.find(params[:friend_id])	
	end

end

