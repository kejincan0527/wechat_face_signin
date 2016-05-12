module ApplicationHelper
  # 根据所在的页面返回完整的标题
  def full_title(page_title = '')
    base_title = "FaceSignin: SenseTime"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
 
  # 登入指定的用户
  def log_in(openid)
    session[:openid] = openid
    cookies.permanent.signed[:openid] = openid
  end

  # 返回 cookie 中记忆令牌对应的用户
  def current_user
    if (openid = session[:openid])
      @current_user ||= User.active.find_by(openid: openid)
    elsif (openid = cookies.signed[:openid])
      user = User.active.find_by(openid: openid)
      if user
        log_in user.openid
        @current_user = user
      end
    else
      redirect_uri = "http://fage.29mins.com/wechats/authorize"
      redirect_to Wechat.auth_url(redirect_uri)
    end
  end

  # 如果用户已登录，返回 true，否则返回 false
  def logged_in?
    !current_user.nil?
  end

  # 忘记持久会话
  def forget(user)
    cookies.delete(:openid)
  end

  # 重定向到存储的地址，或者默认地址
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # 存储以后需要获取的地址
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
