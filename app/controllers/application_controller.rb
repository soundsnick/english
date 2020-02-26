class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
