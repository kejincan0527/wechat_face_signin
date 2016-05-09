class WechatsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: :wx_valid
	
	def wx_valid
		Wechat.check_wx_signature(params[:timestamp], params[:nonce], params[:signature])
		render plain: params[:echostr]
	end
	
end
