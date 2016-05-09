class Wechat
	Token = 'weixinshiyituoshi'

  def  self.check_wx_signature(timestamp, nonce, signature)
	  array = [Token, timestamp, nonce].sort
	  return (signature == Digest::SHA1.hexdigest(array.join) ? true : false)
	end

end
