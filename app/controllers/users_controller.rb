class UsersController < ApplicationController
	before_action :authenticate_user!

	def index

	    if params[:id]
	      @users = User.where('id < ?', params[:id]).limit(5)
	    else
	      @users = User.limit(5)
	    end

	    respond_to do |format|
	      format.html
	      format.js
	      format.json
	    end

	end

end