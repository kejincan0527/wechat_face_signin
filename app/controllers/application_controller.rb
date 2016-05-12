class ApplicationController < ActionController::Base
	require 'nokogiri'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  
	private

		def access_page_auth
			unless logged_in?
				store_location
				flash[:danger] = "请先关注公众号"
				redirect_to root_url
			end
		end
end
