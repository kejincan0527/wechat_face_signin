module WechatReplyClass
  class WEvent
  	include ReplyWeixinMessage

  	def initialize(hash)
        @weixin_message = Message.factory(hash)
      end

    def handle
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

    def subscribe
	    user = User.find_by(id: @weixin_message.EventKey)
      if user
        user.update_attributes(openid: @weixin_message.FromUserName)
      end
      reply_news_message([generate_article('谢谢您的关注','点击查看详情','http://fage.29mins.com/assets/demo_image_file.jpg','http://fage.29mins.com/records')])
    end

    def unsubscribe
      reply_text_message 'success'
    end

    def scan
      user = User.find_by(id: @weixin_message.EventKey)
      reply_news_message([generate_article('扫码颜值机','点击查看详情','http://fage.29mins.com/assets/demo_image_file.jpg','http://fage.29mins.com/records')])
    end

    def common_handle
      
    end

  end
end
