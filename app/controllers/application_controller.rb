class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def auth
    session[:auth]
  end
end
