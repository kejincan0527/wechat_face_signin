class WechatsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: :wx_receive
	
	def wx_valid
		Wechat.check_wx_signature(params[:timestamp], params[:nonce], params[:signature])
		render plain: params[:echostr]
	end

	def wx_receive
		# if result = Wechat.get_xml_content(request.body.read, params[:timestamp], params[:nonce], params[:signature])
		if Wechat.check_wx_signature(params[:timestamp], params[:nonce], params[:signature])
			xml_to_hash = Hash.new
			request.body.read.xml.css('*').each do |tab|
			    xml_to_hash[tab.node_name] = tab.content
			end
		end
		result = WechatReplyClass::CommonHandle.generate_class(xml_to_hash)
		render xml: result
		# render nothing: true
	end
	
end
