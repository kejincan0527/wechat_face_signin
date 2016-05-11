class RecordsController < ApplicationController
	before_action :access_page_auth, only: [:index]

  def index
  	# order("updated_at DESC, openid ASC")
  	@records = Record.all.limit(20).page(params[:page])#.where("user_id IS NOT NULL")
  end
  
end
