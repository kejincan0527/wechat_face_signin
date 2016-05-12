class WechatsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: :wx_receive
	
	def wx_valid
		Wechat.check_wx_signature(params[:timestamp], params[:nonce], params[:signature])
		render plain: params[:echostr]
	end

	def wx_receive
		if Wechat.check_wx_signature(params[:timestamp], params[:nonce], params[:signature])
			xml_to_hash = Hash.new
			Nokogiri::XML(request.body.read).css('*').each do |tab|
			    xml_to_hash[tab.node_name] = tab.content
			end
		end
		puts xml_to_hash
		result = WechatReplyClass::CommonHandle.generate_class(xml_to_hash)
		render xml: result
	end

	def authorize
		if params[:code]
			callback_json = Wechat.get_openid_with_code(params[:code])
			if callback_json['openid']
		    if user = User.active.find_by(openid: callback_json['openid'])
		    	log_in callback_json['openid']
		    	redirect_back_or records_url
		    end
		  else
				flash[:danger] = "用户网页授权失败"
				redirect_to root_url
		  end
		else
			flash[:danger] = "请先关注公众号"
			redirect_to root_url
		end
	end
	
end
