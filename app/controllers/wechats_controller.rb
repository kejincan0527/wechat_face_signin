class WechatsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: :wx_receive
	
	def wx_valid
		Wechat.check_wx_signature(params[:timestamp], params[:nonce], params[:signature])
		render plain: params[:echostr]
	end

	def wx_receive
		if record_id = Wechat.get_xml_content(request.body.read, params[:timestamp], params[:nonce], params[:signature])
			render plain: record_id
		else
			render plain: 'failed'
		end
	end
	
end
