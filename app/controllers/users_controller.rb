class UsersController < ApplicationController
	
	before_action :require_login
	before_action :set_user, only:[:edit, :profile, :update, :destroy, :get_email]

	def index

	    if params[:id]
	      @users = User.gender(current_user).where('id < ?', params[:id]).not_me(current_user).limit(10) - current_user.matches(current_user)
	    else
	      @users = User.gender(current_user).not_me(current_user).limit(10) - current_user.matches(current_user)
	    end

	    respond_to do |format|
	      format.html
	      format.js
	    end

	end


	def edit
	   authorize! :update, @user
	end

	def update
		if @user.update(user_params)
			respond_to do |format|
				format.html {redirect_to users_path}
			end
		else
			redirect_to edit_user_path(@user)
		end
	end


	def profile
	end


	def destroy
		if @user.destroy
			redirect_to root_path
			session[:user_id]  = nil
			session[:omniauth] = nil
		else
			redirect_to edit_user_path(@user)
		end
	end

	def matches
		@matches = current_user.friendships.where(state: "ACTIVE").map(&:friend) + current_user.inverse_friendships.where(state: "ACTIVE").map(&:user)
	end

	def get_email
	  	respond_to do |format|
	      format.js
	    end
  	end


	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:interest, :bio, :image, :location, :date_of_birth)
	end

end


