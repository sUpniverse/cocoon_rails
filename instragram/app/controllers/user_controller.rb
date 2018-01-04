class UserController < ApplicationController
	before_action :is_admin?

	def index
		@users = User.all
	end

	private

	def is_admin?
    	redirect_to '/' and return unless current_user.admin?
  	end

end
