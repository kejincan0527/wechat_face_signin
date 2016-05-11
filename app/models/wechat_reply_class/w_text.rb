module WechatReplyClass
  class WText
  	include ReplyWeixinMessage

  	def initialize(hash)
        @weixin_message = Message.factory(hash)
    end

    def handle
    	case @weixin_message.Content
    	when 'TESTCOMPONENT_MSG_TYPE_TEXT'
    		release_completely
    	else
    		common_handle
    	end
    end

    def release_completely
      reply_text_message "TESTCOMPONENT_MSG_TYPE_TEXT_callback"
    end

    def common_handle
    	reply_text_message @weixin_message.Content
    end

  end
end
