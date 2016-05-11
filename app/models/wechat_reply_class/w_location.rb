module WechatReplyClass
	class WLocation
		include ReplyWeixinMessage

		def initialize(hash)
      @message = Message.factory(hash)
    end

		def handle
		  reply_text_message '无法使用位置信息服务'
		end

		def auto_release
			reply_text_message @message.Event+'from_callback'
		end
	end
end
