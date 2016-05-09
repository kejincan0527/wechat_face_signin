class WechatsController < ApplicationController

	def wx_valid
		Wechat.check_wx_signature(params[:timestamp], params[:nonce], params[:signature])
	end
end
