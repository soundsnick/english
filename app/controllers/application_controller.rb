class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def auth
    session[:auth]
  end

  def isAdmin
    if auth
      session[:auth]['role'] ? true : false
    else
      false
    end
  end
end
