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

  def categoryAdd
    if isAdmin
      if params[:category].length > 2
        @category = Category.new
        @category.title = params[:category]
        # binding.pry
        @category.save
        redirect_to admin_path, notice: 'Категория успешно создана'
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def categoryRemove
    if isAdmin
      if @category = Category.find_by(id: params[:id])
        @category.destroy
        redirect_to admin_path, notice: 'Категория успешно удалена'
      else
        redirect_to admin_path, notice: 'Ошибка'
      end
    else
      redirect_back(fallback_location: root_path)
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
      @categories = Category.all
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def addVideo
    if isAdmin
      uploaded_video = params[:video]
      uploaded_video_name = uploaded_video.original_filename
      uploaded_img = params[:cover]
      uploaded_img_name = uploaded_img.original_filename
      File.open(Rails.root.join('public', 'videos', uploaded_video_name ), 'wb') do |file|
        file.write(uploaded_video.read)
      end
      File.open(Rails.root.join('public', 'thumbs', uploaded_img_name ), 'wb') do |file|
        file.write(uploaded_img.read)
      end
      @video = Video.new
      @video.title = params[:title]
      @video.description = params[:description]
      @video.file = uploaded_video_name
      @video.thumb = uploaded_img_name
      @video.category_id = params[:category]
      @video.save
      redirect_back fallback_location: root_path, notice: 'Видео успешно добавлено'
    else
      redirect_to '/404'
    end
  end

  def edit
    if isAdmin
      if @video = Video.find_by(id: params[:id])
        @app = {'title': "Изменить: #{@video.title}"}
        @categories = Category.all
      else
        redirect_to admin_path, notice: 'Ошибка'
      end
    else
      redirect_to '/404'
    end
  end

  def editVideo
    if isAdmin
      if @video = Video.find_by(id: params[:id])
        uploaded_video_name = @video.file
        uploaded_img_name = @video.thumb
        if params[:video]
          uploaded_video = params[:video]
          uploaded_video_name = uploaded_video.original_filename
          File.delete(Rails.root.join('public', 'videos', @video.file )) if File.exist?(Rails.root.join('public', 'videos', @video.file ))
          File.open(Rails.root.join('public', 'videos', uploaded_video_name ), 'wb') do |file|
            file.write(uploaded_video.read)
          end
        end
        if params[:cover]
          uploaded_img = params[:cover]
          uploaded_img_name = uploaded_video.original_filename
          File.delete(Rails.root.join('public', 'thumbs', @video.thumb )) if File.exist?(Rails.root.join('public', 'thumbs', @video.thumb ))
          File.open(Rails.root.join('public', 'thumbs', uploaded_img_name ), 'wb') do |file|
            file.write(uploaded_img.read)
          end
        end
        @video.title = params[:title]
        @video.description = params[:description]
        @video.file = uploaded_video_name
        @video.thumb = uploaded_img_name
        @video.category_id = params[:category]
        @video.save
        redirect_to admin_path, notice: 'Видео успешно изменено'
      else
        redirect_to admin_path, notice: "Ошибка"
      end
    else
      redirect_to '/404'
    end
  end

end