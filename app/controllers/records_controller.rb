class RecordsController < ApplicationController
  def index
  	@records = Record.all.limit(20).page(params[:page])#.where("user_id IS NOT NULL")
  end
end
