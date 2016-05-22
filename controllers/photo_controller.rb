# get '/photos' do
#   return 'Hello World'
# end

get '/photos/new' do
  #NEW
  @photographers = User.photographers()
  @cameras = Camera.all()
  @lenses = Lens.all()
  erb(:'photo/new')
end

get '/photos' do
  #INDEX
  @photos = Photo.all()
  @comments = Comment.all()
  # binding.pry
  erb(:'photo/index')
end

post '/photos' do
  #CREATE
  # binding.pry
  @photo = Photo.new(params)
  @photo.save()
  erb(:'photo/create')
end

get '/photos/:id' do
  #SHOW
  @photo = Photo.find(params[:id]) #dynamic
  # binding.pry
  erb(:'photo/show')
end

get '/photos/:id/edit' do
  #EDIT
  @photo = Photo.find(params[:id])
  @photographers = User.photographers()
  @cameras = Camera.all()
  @lenses = Lens.all()
  erb(:'photo/edit')
end

put '/photos/:id' do
  #UPDATE
  @photo = Photo.update(params)
  # binding.pry
  redirect to("/photos/#{params[:id]}")
end

delete '/photos/:id' do
  #DELETE
  Photo.destroy(params[:id])
  redirect to('/photos')
end
