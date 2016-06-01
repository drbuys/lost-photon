require('sinatra')
require('sinatra/contrib/all') if development?
require('pry-byebug')
require('securerandom')
require('aws-sdk')
require_relative('models/encryption')
require_relative('models/user')
require_relative('models/comment')
require_relative('models/photo')
require_relative('models/camera')
require_relative('models/lens')
require_relative('controllers/user_controller')
require_relative('controllers/comment_controller')
require_relative('controllers/photo_controller')
require_relative('controllers/camera_controller')
require_relative('controllers/lens_controller')

enable :sessions

get '/' do
    @photos = Photo.all()
    @photo = Photo.randomphoto()
    # binding.pry
    erb(:home)
end

get '/login' do
    @users = User.all()
    @photographers = User.photographers()
    erb(:login)
end

get '/logout' do
    session[:name] = nil
    redirect '/'
end

# post '/signup' do
#     erb(:signup)
# end
