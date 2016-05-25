# get '/comments' do
#   return 'Hello World'
# end

get '/photos/:id/comments/new' do
    if @user = session[:name]
      #NEW
      @photo = Photo.find(params[:id])
      @users = User.all()
      @photos = Photo.all()
      erb(:'comment/new')
  else
      redirect '/'
  end
end

get '/photos/:id/comments' do
    if @user = session[:name]
      #INDEX
      @photo = Photo.find(params[:id])
      @comments = Comment.all()
      # binding.pry
      redirect '/photos/' + params[:id]
    #   erb(:'comment/index')
    else
        redirect '/'
    end
end

post '/photos/:id/comments' do
    if @user = session[:name]
      #CREATE
      # binding.pry
      @photo = Photo.find(params[:id])
      @comment = Comment.new(params)
      @comment.save()
      redirect '/photos/' + params[:id]
    #   erb(:'comment/create')
  else
      redirect '/'
  end
end

get '/photos/:photo_id/comments/:comment_id' do
    if @user = session[:name]
      #SHOW
      @photo = Photo.find(params[:photo_id])
      @comment = Comment.find(params[:comment_id]) #dynamic
      # binding.pry
      erb(:'comment/show')
    else
        redirect '/'
    end
end

get '/photos/:photo_id/comments/:comment_id/edit' do
    if @user = session[:name]
      #EDIT
      @photo = Photo.find(params[:photo_id])
      @comment = Comment.find(params[:comment_id])
      erb(:'comment/edit')
  else
      redirect '/'
  end
end

put '/photos/:photo_id/comments/:comment_id' do
    if @user = session[:name]
      #UPDATE
      @photo = Photo.find(params[:photo_id])
      @comment = Comment.update(params)
    #   @comment = Comment.find(params[:comment_id])

      redirect to("/photos/#{params[:photo_id]}/comments/#{params[:comment_id]}")
  else
      redirect '/'
  end
end

delete '/photos/:photo_id/comments/:comment_id' do
    if @user = session[:name]
      #DELETE
      @photo = Photo.find(params[:photo_id])
      Comment.destroy(params[:comment_id])
      redirect to("/photos/#{params[:photo_id]}/comments")
  else
      redirect '/'
  end
end
