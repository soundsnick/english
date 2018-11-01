class UserController < ApplicationController

  def login_page
    @app = {'title': "Добро пожаловать"}
    render 'login'
  end

  def register_page
    @app = {'title': "Регистрация"}
    render 'register'
  end

  def login
    if(params[:email] && params[:password])

    else
      redirect_to login_path, notice: 'Заполните все поля'
    end
  end

  def register

  end
end