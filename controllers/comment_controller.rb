# get '/comments' do
#   return 'Hello World'
# end

get '/comments/new' do
  #NEW
  @users = User.all()
  @photos = Photo.all()
  erb(:'comment/new')
end

get '/comments' do
  #INDEX
  @comments = Comment.all()
  # binding.pry
  erb(:'comment/index')
end

post '/comments' do
  #CREATE
  # binding.pry
  @comment = Comment.new(params)
  @comment.save()
  erb(:'comment/create')
end

get '/comments/:id' do
  #SHOW
  @comment = Comment.find(params[:id]) #dynamic
  # binding.pry
  erb(:'comment/show')
end

get '/comments/:id/edit' do
  #EDIT
  @comment = Comment.find(params[:id])
  erb(:'comment/edit')
end

put '/comments/:id' do
  #UPDATE
  @comment = Comment.update(params)
  # binding.pry
  redirect to("/comments/#{params[:id]}")
end

delete '/comments/:id' do
  #DELETE
  Comment.destroy(params[:id])
  redirect to('/comments')
end
