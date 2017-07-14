helpers do
  def render_view(path, options = {})
    haml(path.to_sym, options)
  end

  def is_link_active?(request, controller)
    routes = request.path_info.split('/')
    if routes.length == 0 && controller == 'root'
      true
    else
      routes[1] == controller
    end
  end
end
