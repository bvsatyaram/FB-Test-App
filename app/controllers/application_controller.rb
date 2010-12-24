class ApplicationController < ActionController::Base
  attr_accessor :current_user
  helper_method :authentication_callback_url

  protect_from_forgery
  before_filter :authorization_required

  def request_from_facebook?
    request.referrer == FB_APP_URL
  end

  def authorization_required
    if session[:fb_user]
      @current_user = session[:fb_user]
    else
      redirect_to client.web_server.authorize_url(:redirect_uri => authentication_callback_url, :scope => 'email,offline_access')
    end
  end

  protected

  def client
    OAuth2::Client.new(APP_ID, APP_SECRET, :site => FB_API_SITE)
  end

  def authentication_callback_url
    home_authenticate_url
  end
end
