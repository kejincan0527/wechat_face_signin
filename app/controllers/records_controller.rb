class RecordsController < ApplicationController
  def index
  	# order("updated_at DESC, openid ASC")
  	@records = Record.all.limit(20).page(params[:page])#.where("user_id IS NOT NULL")
  end
end
