class HomeController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => :request_from_facebook?
  skip_before_filter :authorization_required, :only => [:authenticate]

  def index
  end

  def authenticate
    access_token = client.web_server.get_access_token(params[:code], :redirect_uri => authentication_callback_url)
    session[:fb_user] = JSON.parse access_token.get('/me')

    @current_user = session[:fb_user]
    redirect_to root_path
  end
end
