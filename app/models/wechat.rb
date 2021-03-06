class Wechat
	require 'nokogiri'

	AppID = 'wx613720b24293cfa5'
	AppSecret = '8b01c7e2eb59d2bd09fdfef3bd3632c3'
	Token = 'weixinshiyituoshi'

	# 配置微信接口/服务器资源
  def self.check_wx_signature(timestamp, nonce, signature)
	  array = [Token, timestamp, nonce].sort
	  return (signature == Digest::SHA1.hexdigest(array.join) ? true : false)
	end

	# 获取微信xml内容
  def self.get_xml_content(request, timestamp, nonce, signature)
    if check_wx_signature(timestamp, nonce, signature)
      record_id = Nokogiri::XML(request).at('EventKey').content
    else
      record_id = nil
    end
  end

	# 获取微信acess_token
	def self.get_access_token
		begin
			if Rails.cache.read(:access_token)
				Rails.cache.read(:access_token)
			else
				uri = URI("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{AppID}&secret=#{AppSecret}")
				res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
				  req = Net::HTTP::Get.new(uri, {'Content-Type'=>'application/json'})
				  http.request(req)
				end
			  result = JSON.parse(res.body)["access_token"]
			  Rails.cache.write(:access_token, result, expires_in: 1.8.hours)
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

	# 微信文档: http://mp.weixin.qq.com/wiki/1/8a5ce6257f1d3b2afb20f83e72b72ce9.html
	def self.get_subscribed_user_info(openid)
		begin
			uri = URI("https://api.weixin.qq.com/cgi-bin/user/info?access_token="+Wechat.get_access_token+"&openid=#{openid}&lang=zh_CN")
	    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
	      req = Net::HTTP::Get.new(uri,{'Content-Type'=>'application/json'})
	      http.request(req)
	    end
	    result = JSON.parse(res.body)
	  rescue => e; p e;
	  end
	end

	def self.auth_url(redirect_uri)
		"https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{AppID}&redirect_uri=#{redirect_uri}&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect"
	end

	def self.get_openid_with_code(code)
		begin
			uri = URI("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{AppID}&secret=#{AppSecret}&code=#{code}&grant_type=authorization_code")
	    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
	      req = Net::HTTP::Get.new(uri,{'Content-Type'=>'application/json'})
	      http.request(req)
	    end
	    result = JSON.parse(res.body)
	  rescue => e; p e;
	  end
	end

end
