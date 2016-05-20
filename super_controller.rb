require('sinatra')
require('sinatra/contrib/all') if development?
require('pry-byebug')
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

get '/' do
  erb(:home)
end
