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
      redirect '/login'
  end
end

post '/photos' do
    if @user = session[:name]
        params["object"][:filename] = SecureRandom.hex(10)
        if params["object"][:type] == 'image/gif'
            params["object"][:filename] += '.gif'
        elsif params["object"][:type] == 'image/jpeg'
            params["object"][:filename] += '.jpg'
        elsif params["object"][:type] == 'image/pjpeg'
            params["object"][:filename] += '.jpg'
        elsif params["object"][:type] == 'image/png'
            params["object"][:filename] += '.png'
        else
            params["object"][:filename]
        end

        # Aws.config({access_key_id: awskey, secret_acces_key: awssecret})
        # Aws.config.update({credentials: Aws::Credentials.new(awskey, awssecret)})
        # Aws.config[:credentials] = Aws::Credentials.new(awskey, awssecret)
        # Aws::S3::Base.establish_connection!(
        #   :access_key_id     => awskey,
        #   :secret_access_key => awssecret
        # )

        bucketname     = 'lostphoton-assets'
        file       = params["object"][:tempfile]
        filename   = params["object"][:filename]

        s3 = Aws::S3::Resource.new({credentials: Aws::Credentials.new(ENV['S3_KEY'], ENV['S3_SECRET']), region: 'us-east-1'})
        bucket = s3.bucket(bucketname)
        obj = bucket.object(filename)
        obj.upload_file(file, acl:'public-read')

        # bucket.objects.limit(50).each do |item|
        #   puts "Name:  #{item.key}"
        #   puts "URL:   #{item.presigned_url(:get)}"
        # end

        # url = obj.public_url

        # url = "https://#{bucket}.s3.amazonaws.com/#{filename}"
        # return url
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
