# get '/users' do
#   return 'Hello World'
# end

get '/users/new' do
  #NEW
  erb(:'user/new')
end

get '/users' do
  #INDEX
  @users = User.all()
  @photographers = User.photographers()
  # binding.pry
  erb(:'user/index')
end

post '/users' do
  #CREATE
  # binding.pry
  @user = User.new(params)
  @user.save()
  @photographers = User.photographers()
  erb(:'user/create')
end

get '/users/:id' do
  #SHOW
  @user = User.find(params[:id]) #dynamic
  # binding.pry
  erb(:'user/show')
end

get '/users/:id/edit' do
  #EDIT
  @user = User.find(params[:id])
  erb(:'user/edit')
end

put '/users/:id' do
  #UPDATE
  @user = User.update(params)
  # binding.pry
  redirect to("/users/#{params[:id]}")
end

delete '/users/:id' do
  #DELETE
  User.destroy(params[:id])
  redirect to('/users')
end
