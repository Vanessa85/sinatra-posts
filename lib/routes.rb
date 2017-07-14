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

# **** users ****
get '/users' do
  @users = User.where.not(id: session[:user_id])
  render_view '/users/index'
end

get '/users/edit/:id/?' do
  @user = User.find(params[:id])
  render_view 'users/edit'
end

post '/users/edit/:id' do
  @user = User.find(params[:id])
  if params[:user][:password].empty?
    params[:user][:password] = @user.password
  else
    md5sum = Digest::MD5.hexdigest(params[:user][:password])
    params[:user][:password] = md5sum
  end

  if @user.update(params[:user])
    redirect '/users'
  else
    render_view 'users/edit'
  end
end

# **** lists ****
get '/lists/new/?' do
  @list = List.new
  render_view 'lists/new'
end

post '/lists/new' do
  user = User.find(session[:user_id])
  @list = List.new_list(params[:list], user)
  render_view 'lists/new'
  # redirect request.referer
  # redirect '/'
end
