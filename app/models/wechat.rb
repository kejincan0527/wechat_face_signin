class Wechat

	AppID = 'wx613720b24293cfa5'
	AppSecret = '8b01c7e2eb59d2bd09fdfef3bd3632c3'
	Token = 'weixinshiyituoshi'

	# 配置微信接口/服务器资源
  def self.check_wx_signature(timestamp, nonce, signature)
	  array = [Token, timestamp, nonce].sort
	  return (signature == Digest::SHA1.hexdigest(array.join) ? true : false)
	end

	# 获取微信acess_token
	def self.get_access_token
		begin
			if Rails.cache.read("access_token")
				Rails.cache.read("access_token")
			else
				uri = URI("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{AppID}&secret=#{AppSecret}")
				res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
				  req = Net::HTTP::Get.new(uri, {'Content-Type'=>'application/json'})
				  http.request(req)
				end
			  result = JSON.parse(res.body)["access_token"]
			  Rails.cache.write("access_token", result, expires_in: 1.8.hours)
			  result
			end
    rescue => e; p e;
    end
	end

	# 生成临时二维码
	def self.get_qrcode_url(id)
		begin
			uri = URI("https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token="+Wechat.get_access_token)
	    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
	      req = Net::HTTP::Post.new(uri,{'Content-Type'=>'application/json'})
	      req.body = {"expire_seconds": 86400, "action_name": 'QR_SCENE', "action_info": {"scene": {"scene_id": id}}}.to_json
	      http.request(req)
	    end
	    result = JSON.parse(res.body)["url"]
	  rescue => e; p e;
	  end
	end

end
