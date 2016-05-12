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
      openid = @weixin_message.FromUserName
      subscribed_user_info = Wechat.get_subscribed_user_info(openid)
      puts subscribed_user_info
      user = User.create(nickname: subscribed_user_info['nickname'], sex: subscribed_user_info['sex'], avatar: subscribed_user_info['headimgurl'], openid: openid, subscribed_at: Time.now)
      if record = Record.find_by(id: @weixin_message.EventKey.delete('qrscene_'))
        record.update_attributes(user_id: user.id)
      end
      reply_news_message([generate_article('谢谢您的关注','点击查看详情','http://fage.29mins.com/assets/demo_image_file.jpg','http://fage.29mins.com/records')])
    end

    def unsubscribe
      user = User.find_or_initialize_by(del: false, openid: @weixin_message.FromUserName)
      user.del = true
      user.save
      reply_text_message 'success'
    end

    def scan
      user = User.find_by(del: false, openid: @weixin_message.FromUserName)
      if user && (record = Record.find_by(id: @weixin_message.EventKey.delete('qrscene_')))
        record.update_attributes(user_id: user.id)
      end
      reply_news_message([generate_article('扫码颜值机','点击查看详情','http://fage.29mins.com/assets/demo_image_file.jpg','http://fage.29mins.com/records')])
    end

    def common_handle
      
    end

  end
end
