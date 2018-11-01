class AppController < ApplicationController

  def home

    @app = {'title': "Главная"}
  end

  def about
    @app = {'title': "О нас"}
  end
end