module ApplicationHelper

  private

  def config
    {
        'name': 'Upmind',
        'email': 'soundsnick@gmail.com'
    }
  end

  def navigation_items
    [
        ['Главная', '/', false],
        # ['О нас', about_path, false]
    ]
  end

  def categories
    Category.all
  end

  def auth
    session['auth'] ? true : false
  end

  def isAdmin
    if auth
      session[:auth]['role'] ? true : false
    else
      false
    end
  end
end
