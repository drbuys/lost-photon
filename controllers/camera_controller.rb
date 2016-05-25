# get '/cameras' do
#   return 'Hello World'
# end
#
get '/cameras/new' do
  #NEW
  erb(:'camera/new')
end

get '/cameras' do
    if @user = session[:name]
      #INDEX
      @cameras = Camera.all()
      @lenses = Lens.all()
      # binding.pry
      erb(:'camera/index')
  else
      redirect '/login'
  end
end

post '/cameras' do
  #CREATE
  # binding.pry
  @camera = Camera.new(params)
  @camera.save()
  erb(:'camera/create')
end

get '/cameras/:id' do
  #SHOW
  @camera = Camera.find(params[:id]) #dynamic
  # binding.pry
  erb(:'camera/show')
end

get '/cameras/:id/edit' do
  #EDIT
  @camera = Camera.find(params[:id])
  erb(:'camera/edit')
end

put '/cameras/:id' do
  #UPDATE
  @camera = Camera.update(params)
  # binding.pry
  redirect to("/cameras/#{params[:id]}")
end

delete '/cameras/:id' do
  #DELETE
  Camera.destroy(params[:id])
  redirect to('/cameras')
end
