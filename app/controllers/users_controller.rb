class UsersController < ApplicationController
  before_action :access_page_auth, only: [:profile, :new, :create, :index]

  def index

  end

  def profile
  end

  def new
  end

  def create
  	if current_user.update_attributes(user_params)
	  	flash[:success] = '成功编辑用户信息'
	  	redirect_to user_profile_path
	  else
	  	flash[:danger] = '编辑用户信息失败'
	  	redirect_to :back
	  end
  end

  private

  	def user_params
  		params.permit(:name, :phone, :profession)
  	end
  
end
