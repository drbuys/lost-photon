# get '/photos' do
#   return 'Hello World'
# end

get '/photos/new' do
  #NEW
  if  @user = session[:name]
      @photographers = User.photographers()
      @cameras = Camera.all()
      @lenses = Lens.all()
      erb(:'photo/new')
  else
      redirect '/photos'
  end
end

    #displays top rated photograph
get '/photos/topratedphoto' do
    if @user = session[:name]
        @topratedphoto = Photo.top_rated_photo()
        erb(:'photo/topratedphoto')
    else
        redirect '/photos'
    end
end

#displays top rated equipment
get '/photos/topratedequipment' do
    if @user = session[:name]
        @topratedcamera = Photo.cameracount()
        @topratedlens = Photo.lenscount()
        erb(:'photo/topratedequipment')
    else
        redirect '/photos'
    end
end

#displays top rated equipment
get '/photos/mostphotos' do
    if @user = session[:name]
        @photos = Photo.all()
        @comments = Comment.all()
        @mostphotos = Photo.photographercount()
        erb(:'photo/mostphotos')
    else
        redirect '/photos'
    end
end

get '/photos' do
    if @user = session[:name]
        #INDEX
      @photos = Photo.all()
      @comments = Comment.all()
    #   @topratedphoto = Photo.top_rated_photo()
      # binding.pry
      erb(:'photo/index')
  else
      redirect '/'
  end
end

post '/photos' do
    if @user = session[:name]
      #CREATE
      # binding.pry
      @photo = Photo.new(params)
      @photo.save()
      erb(:'photo/create')
  else
      redirect '/photos'
  end
end

get '/photos/:id' do
    if @user = session[:name]
        #SHOW
        @photo = Photo.find(params[:id]) #dynamic
        @comments = Comment.all()
        # binding.pry
        erb(:'photo/show')
      else
          redirect '/'
      end
end

get '/photos/:id/edit' do
  #EDIT
  if @user = session[:name]
      @photo = Photo.find(params[:id])
      @photographers = User.photographers()
      @cameras = Camera.all()
      @lenses = Lens.all()
      @user = session[:name]
      erb(:'photo/edit')
  else
      redirect '/photos'
  end
end

put '/photos/:id' do
  #UPDATE
  if @user = session[:name]
      @photo = Photo.update(params)
      # binding.pry
      redirect to("/photos/#{params[:id]}")
  else
      redirect '/photos'
  end
end

delete '/photos/:id' do
    if @user = session[:name]
      #DELETE
      Photo.destroy(params[:id])
      redirect to('/photos')
    else
        redirect '/photos'
    end
end
