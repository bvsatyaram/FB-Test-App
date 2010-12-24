class HomeController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => :request_from_facebook?
  skip_before_filter :authorization_required, :only => [:authenticate]

  def index
  end

  def authenticate
    oauth_response = oclient.web_server.get_access_token(params[:code], :redirect_uri => authentication_callback_url)
    session[:access_token] = oauth_response.token

    redirect_to home_index_path
  end

  def start
    redirect_to oclient.web_server.authorize_url(:redirect_uri => authentication_callback_url, :scope => 'email,offline_access,publish_stream')
  end

  def publish
    fbclient.selection.me.feed.publish!(:message => "Server Publish", :name => "Chronus")
    redirect_to home_index_path
  end
end
