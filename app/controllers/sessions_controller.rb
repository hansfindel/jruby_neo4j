class SessionsController < ApplicationController
	def new #login view
	end
	def create #login process 
		user = Session.authenticate(params)
		if user
			session[:user_id] = user.id
			redirect_to root_path
		else
			redirect_to root_path, :notice => "Could not login"
		end
	end
	def destroy #logout
		session[:user_id] = nil
		session = nil
		redirect_to root_path, :notice => "You are logged out"
	end
end