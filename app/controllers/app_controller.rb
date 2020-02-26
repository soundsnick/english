class AppController < ApplicationController

  def home
    if auth
      @app = {'title': "Главная", 'title': "Новые"}
      @videos = Course.joins(:category)
    else
      @app = {'title': "Главная", 'title': "Новые"}
      render 'landing'
    end
  end

  def category
    if auth
      if @cat = Category.find_by(id: params[:id])
        @app = {'title': @cat.title, 'title': "Категория: #{@cat.title}"}
        @videos = Course.joins(:category).where(category_id: params[:id])
        render 'home'
      else
        redirect_to '/404'
      end
    else
      redirect_to root_path
    end
  end

  def coursePage
    if auth
      if @cat = Course.find_by(id: params[:id])
        @app = {'title': @cat.title, 'title': "Категория: #{@cat.title}"}
        @videos = Video.joins(:course).where(course_id: params[:id])
      else
        redirect_to '/404'
      end
    else
      redirect_to root_path
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
        @courses = Course.where(category_id: params[:id])
        @courses.each do |course|
          @videos = Video.where(course_id: course.id)
          @videos.each do |video|
            File.delete(Rails.root.join('public', 'videos', video.file )) if File.exist?(Rails.root.join('public', 'videos', video.file ))
            File.delete(Rails.root.join('public', 'thumbs', video.thumb )) if File.exist?(Rails.root.join('public', 'thumbs', video.thumb ))
            video.destroy
          end
          File.delete(Rails.root.join('public', 'courses', course.cover )) if File.exist?(Rails.root.join('public', 'courses', course.cover ))
          course.destroy
        end
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
    if auth
      if @video = Video.joins(:course).where(id: params[:id]).take
        if UserCourse.where(user_id: session[:auth]['id'], course_id: @video.course_id).length != 0 or isAdmin
          @app = {'title': @video.title}
        else
          redirect_back fallback_location: root_path, notice: 'Вы должны купить курс чтобы смотреть это видео'
        end
      else
        redirect_to '/404'
      end
    else
      redirect_to root_path
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
        File.delete(Rails.root.join('public', 'videos', @video.file )) if File.exist?(Rails.root.join('public', 'videos', @video.file ))
        File.delete(Rails.root.join('public', 'thumbs', @video.thumb )) if File.exist?(Rails.root.join('public', 'thumbs', @video.thumb ))
        @video.destroy
        redirect_back(fallback_location: admin_path)
      end
    end
  end

  def add
    if isAdmin
      @app = {'title': 'Добавить видео'}
      @categories = Course.all
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def addTwo
    if isAdmin
      if @cat = Course.find_by(id: params[:id])
        @app = {'title': "Добавить видео"}
      else
        redirect_to admin_path
      end
    else
      redirect_to '/404'
    end
  end

  def courseRemove
    if isAdmin
      if params[:id]
        if @course = Course.find_by(id: params[:id])
          @videos = Video.where(course_id: @course.id)
          @videos.each do |video|
            File.delete(Rails.root.join('public', 'videos', video.file )) if File.exist?(Rails.root.join('public', 'videos', video.file ))
            File.delete(Rails.root.join('public', 'thumbs', video.thumb )) if File.exist?(Rails.root.join('public', 'thumbs', video.thumb ))
            @video.destroy
          end
          File.delete(Rails.root.join('public', 'courses', @course.cover )) if File.exist?(Rails.root.join('public', 'courses', @course.cover ))
          @course.destroy
          redirect_to admin_path, notice: 'Успешно удалено'
        else redirect_to admin_path, notice: 'Курс не найден'
        end
      else redirect_to admin_path, notice: 'Курс не найден'
      end
    else
      redirect_to root_path, notice: 'Вы не являетесь администратором!'
    end
  end

  def addVideo
    if isAdmin
      uploaded_video = params[:video]
      uploaded_video_name = uploaded_video.original_filename
      uploaded_img = params[:cover]
      image = params[:cover]
      imagehex = Digest::SHA256.hexdigest image.original_filename
      imagehex = imagehex.slice(0, 10)
      imagehex2 = Digest::SHA256.hexdigest rand(0..100).to_s
      imagehex2 = imagehex2.slice(0, 10)
      imagehex = imagehex2 + imagehex

      uploaded_img_name = uploaded_img.original_filename
      File.open(Rails.root.join('public', 'videos', imagehex + uploaded_video_name ), 'wb') do |file|
        file.write(uploaded_video.read)
      end
      File.open(Rails.root.join('public', 'thumbs', imagehex + uploaded_img_name ), 'wb') do |file|
        file.write(uploaded_img.read)
      end
      @video = Video.new
      @video.title = params[:title]
      @video.description = params[:description]
      @video.file = imagehex + uploaded_video_name
      @video.thumb = imagehex + uploaded_img_name
      @video.course_id = params[:category]
      @video.save
      redirect_to admin_path, notice: 'Видео успешно добавлено'
    else
      redirect_to '/404'
    end
  end

  def edit
    if isAdmin
      if @video = Video.find_by(id: params[:id])
        @app = {'title': "Изменить: #{@video.title}"}
        @categories = Course.all
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
          uploaded_video_name = params[:video].original_filename
          File.delete(Rails.root.join('public', 'videos', @video.file )) if File.exist?(Rails.root.join('public', 'videos', @video.file ))
          File.open(Rails.root.join('public', 'videos', uploaded_video_name ), 'wb') do |file|
            file.write(uploaded_video.read)
          end
        end
        if params[:cover]
          uploaded_img = params[:cover]
          uploaded_img_name = params[:cover].original_filename
          File.delete(Rails.root.join('public', 'thumbs', @video.thumb )) if File.exist?(Rails.root.join('public', 'thumbs', @video.thumb ))
          File.open(Rails.root.join('public', 'thumbs', uploaded_img_name ), 'wb') do |file|
            file.write(uploaded_img.read)
          end
        end
        @video.title = params[:title]
        @video.description = params[:description]
        @video.file = uploaded_video_name
        @video.thumb = uploaded_img_name
        @video.course_id = params[:category]
        @video.save
        redirect_to admin_path, notice: 'Видео успешно изменено'
      else
        redirect_to admin_path, notice: "Ошибка"
      end
    else
      redirect_to '/404'
    end
  end

  def newCourse
    if isAdmin
      @app = {'title': "Создать новый курс"}
      @categories = Category.all
    else
      redirect_to '/404'
    end
  end

  def newCourseTwo
    if isAdmin
      if @cat = Category.find_by(id: params[:id])
        @app = {'title': "Создать новый курс"}
      else
        redirect_to admin_path
      end
    else
      redirect_to '/404'
    end
  end

  def newCoursePost
    if isAdmin
      uploaded_img = params[:cover]
      uploaded_img_name = uploaded_img.original_filename
      File.open(Rails.root.join('public', 'courses', uploaded_img_name ), 'wb') do |file|
        file.write(uploaded_img.read)
      end
      @video = Course.new
      @video.title = params[:title]
      @video.description = params[:description]
      @video.cover = uploaded_img_name
      @video.category_id = params[:category]
      @video.price = params[:price]
      @video.save
      redirect_to admin_path, notice: 'Курс успешно создан'
    else
      redirect_to '/404'
    end
  end

  def editCourse
    if isAdmin
      if @video = Course.find_by(id: params[:id])
        @app = {'title': "Изменить: #{@video.title}"}
        @categories = Category.all
      else
        redirect_to admin_path, notice: 'Ошибка'
      end
    else
      redirect_to '/404'
    end
  end

  def editCoursePost
    if isAdmin
      if @video = Course.find_by(id: params[:id])
        uploaded_img_name = @video.cover
        if params[:cover]
          uploaded_img = params[:cover]
          uploaded_img_name = params[:cover].original_filename
          File.delete(Rails.root.join('public', 'courses', @video.cover )) if File.exist?(Rails.root.join('public', 'courses', @video.cover ))
          File.open(Rails.root.join('public', 'courses', uploaded_img_name ), 'wb') do |file|
            file.write(uploaded_img.read)
          end
        end
        @video.title = params[:title]
        @video.description = params[:description]
        @video.cover = uploaded_img_name
        @video.category_id = params[:category]
        @video.price = params[:price]
        @video.save
        redirect_to admin_path, notice: 'Изменения в курсе сохранены'
      else
        redirect_to admin_path, notice: "Ошибка"
      end
    else
      redirect_to '/404'
    end
  end

  def buyCourse
    if auth
      if @course = Course.find_by(id: params[:id])
        @user = User.find_by(id: session[:auth]["id"])
        if UserCourse.where(user_id: @user.id, course_id: @course.id).length == 0
          if @course.price < @user.balance
            @user.balance -= @course.price
            @user.save
            @transaction = UserCourse.new
            @transaction.user_id = @user.id
            @transaction.course_id = @course.id
            @transaction.save
            redirect_back fallback_location: root_path, notice: 'Покупка прошла успешно. Вы можете найти свои курсы через меню сверху'
          else
            redirect_to root_path, notice: 'У вас недостаточно денег на балансе'
          end
        else
          redirect_back fallback_location: root_path, notice: 'Вы уже купили этот курс'
        end

      else
        redirect_back fallback_location: root_path
      end
    else
      redirect_to login_path
    end
  end

end
