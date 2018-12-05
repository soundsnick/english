class UserController < ApplicationController

  def login_page
    unless auth
      @app = {'title': "Добро пожаловать"}
      render 'login'
    else
      redirect_to root_path
    end

  end

  def register_page
    @app = {'title': "Регистрация"}
    render 'register'
  end

  def login
    if(params[:email] && params[:password])
      if @user = User.find_by(email: params[:email])
        if @user.password == params[:password]
          session[:auth] = nil
          session[:auth] = @user
          redirect_to root_path, notice: 'Добро пожаловать'
        else
          redirect_to login_path, notice: 'Неправильный пароль'
        end
      else
        redirect_to login_path, notice: 'Аккаунт не найден'
      end
    else
      redirect_to login_path, notice: 'Заполните все поля'
    end
  end

  def logout
    session[:auth] = nil
    redirect_to root_path
  end
end