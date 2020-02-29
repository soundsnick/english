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
    unless auth
      @app = {'title': "Регистрация"}
      render 'register'
    else
      redirect_to root_path
    end
  end

  def register
    unless auth
      if params[:email] && params[:name] && params[:password] && params[:password_confirm]
        if params[:password] != params[:password_confirm]
          redirect_back fallback_location: root_path, notice: 'Пароли не совпадают'
        else
          unless @user = User.find_by(email: params[:email])
            @user = User.new
            @user.email = params[:email]
            @user.name = params[:name]
            @user.password = params[:password]
            @user.balance = 0
            @user.save
            session[:auth] = @user
            redirect_to root_path, notice: 'Добро пожаловать'
          else
            redirect_back fallback_location: root_path, notice: 'Данная почта уже занята'
          end
        end
      else
        redirect_back fallback_location: root_path, notice: 'Заполните все поля'
      end
    else
      redirect_to root_path
    end
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
