module WechatReplyClass
  class WEvent
  	include ReplyWeixinMessage

  	def initialize(hash)
        @weixin_message = Message.factory hash
        # @sangna_config = SangnaConfig.find_by_appid(appid)
      end

    def handle
    	if @weixin_message.ToUserName == 'gh_1f5e5525a170'
    		reply_text_message @weixin_message.Event+"from_callback"
    	else
      	case @weixin_message.Event
      	when 'subscribe'
      		subscribe
      	when 'unsubscribe'
      		unsubscribe
      	when 'SCAN'
      		scan
      	else
      		common_handle
      	end
  	  end
    end

    def subscribe
	    user = User.find(@weixin_message.EventKey)
      if user
        user.update_attributes(openid: @weixin_message.FromUserName)
      end
      reply_news_message([generate_article('谢谢您的关注','点击查看详情','https://ruby-china-files.b0.upaiyun.com/user/big_avatar/17890.jpg','http://sensetime.com/cn')])
    end

    def unsubscribe
      # customer = CustomerList.find_or_initialize_by(openid:@weixin_message.FromUserName)
      # customer.del = 2
      # customer.updatetime = Time.now.to_i
      # customer.save
      reply_text_message 'success'
    end

    def scan
      user = User.find(@weixin_message.EventKey)
      reply_news_message([generate_article('扫码颜值机','点击查看详情','https://ruby-china-files.b0.upaiyun.com/user/big_avatar/17890.jpg','http://sensetime.com/cn')])
    end

    def common_handle
      
    end

  end
end
