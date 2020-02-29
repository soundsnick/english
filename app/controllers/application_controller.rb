class ApplicationController < ActionController::Base
  

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
