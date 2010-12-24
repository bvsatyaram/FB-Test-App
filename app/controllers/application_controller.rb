class ApplicationController < ActionController::Base
  attr_accessor :current_user
  helper_method :authentication_callback_url, :current_user, :fbclient

  protect_from_forgery
#  before_filter :authorization_required

  def request_from_facebook?
    !!(request.referrer.match(FB_APP_URL))
  end

  # For now not using it
  def authorization_required
    return
    if session[:fb_user] && session[:access_token]
      @current_user = session[:fb_user]
    else
      redirect_to oclient.web_server.authorize_url(:redirect_uri => authentication_callback_url, :scope => 'email,offline_access,publish_stream')
    end
  end

  protected

  def oclient
    OAuth2::Client.new(APP_ID, APP_SECRET, :site => FB_API_SITE)
  end

  def fbclient
    @fbclient ||= FBGraph::Client.new(:client_id => APP_ID, :secret_id => APP_SECRET, :token => session[:access_token])
  end

  def current_user
    @current_user ||= fbclient.selection.me.info!
  end

  def authentication_callback_url
    home_authenticate_url
  end
end
