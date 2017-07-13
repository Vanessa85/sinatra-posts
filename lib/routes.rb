before do
  if !['login', 'signup'].include?(request.path_info.split('/')[1]) and session[:user_id].nil?
    redirect '/login'
  end
end

get '/' do
  user = User.find(session[:user_id])
  @lists = List.joins(:permissions).where('permissions.user_id = ?', user.id)
  render_view 'lists/index'
end

# **** Authentication ****
get '/signup/?' do
  if session[:user_id].nil?
    render_view 'auth/signup'
  else
    redirect '/'
  end
end

post '/signup/?' do
  md5sum = Digest::MD5.hexdigest(params[:password])
  User.create(name: params[:name], password: md5sum)
  redirect '/login'
end

get '/login/?' do
  if session[:user_id].nil?
    render_view 'auth/login'
  else
    redirect '/'
  end
end

post '/login' do
  md5sum = Digest::MD5.hexdigest(params[:password])
  user = User.where(name: params[:name], password: md5sum).first
  if user.nil?
    @error = 'Invalid login credentials'
    render_view 'auth/login'
  else
    session[:user_id] = user.id
    redirect '/'
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/login'
end

# **** lists ****
get '/lists/new/?' do
  render_view 'lists/new'
end

post '/lists/new' do
  user = User.find(session[:user_id])
  list = List.new_list(params[:name], params[:shared_with], user)
  # redirect request.referer
  redirect '/'
end
