# get '/users' do
#   return 'Hello World'
# end

get '/users/new' do
  #NEW
  erb(:'user/new')
end

get '/users' do
    if @user = session[:name]
      #INDEX
      @users = User.all()
      @photographers = User.photographers()
      # binding.pry
      erb(:'user/index')
  else
      redirect '/login'
  end
end

post '/users/new' do
  #CREATE
  # binding.pry
  if  @user = User.new(params)
      session[:name] = @user.save()
      @photographers = User.photographers()
      erb(:'user/create')
  else
      redirect '/login'
  end
end

put '/users' do
    if  @user = User.login(params)
        session[:name] = @user
        erb(:'user/create')
    else
        redirect '/'
    end
end

get '/users/:id' do
      #SHOW
    if  @user = session[:name]
        @displayuser = User.find(params[:id])
        @photos = Photo.all()
        # binding.pry
        erb(:'user/show')
    else
        redirect '/users'
    end
end

get '/users/:id/edit' do
  #EDIT
  if  @user = session[:name]
      if params[:id].to_i == @user.id
          erb(:'user/edit')
      else
          redirect '/users'
      end
  else
      redirect '/users'
  end
end

put '/users/:id' do
  #UPDATE
  if  @user = session[:name]
      @user = User.update(params)
      # binding.pry
      redirect to("/users/#{params[:id]}")
  else
      redirect '/users'
  end
end

delete '/users/:id' do
    if    @user = session[:name]
      #DELETE
      User.destroy(params[:id])
      redirect to('/users')
  else
      redirect '/users'
  end
end
