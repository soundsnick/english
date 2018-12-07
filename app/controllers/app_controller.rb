class AppController < ApplicationController

  def home
    @app = {'title': "Главная", 'title': "Новые"}
    @videos = Video.joins(:category).limit(12)
  end

  def category
    if @cat = Category.find_by(id: params[:id])
      @app = {'title': @cat.title, 'title': "Категория: #{@cat.title}"}
      @videos = Video.joins(:category).where(category_id: params[:id])
      render 'home'
    else
      redirect_to '/404'
    end
  end

  def video
    if @video = Video.joins(:category).where(id: params[:id]).take
      @app = {'title': @video.title}
    else
      redirect_to '/404'
    end
  end

  def about
    @app = {'title': "О нас"}
  end

  def admin
    unless isAdmin
      redirect_to login_path, notice: 'Вы не являетесь администратором'
    else
      @app = {'title': 'Администратор'}
      @videos = Video.all
    end
  end

  def remove
    if isAdmin
      if @video = Video.find_by(id: params[:id])
        @video.destroy
        redirect_back(fallback_location: admin_path)
      end
    end
  end

  def add
    if isAdmin
      @app = {'title': 'Добавить видео'}
    else
      redirect_back(fallback_location: root_path)
    end
  end

end