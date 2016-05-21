# get '/lenses' do
#   return 'Hello World'
# end
#
get '/lenses/new' do
  #NEW
  erb(:'lens/new')
end

get '/lenses' do
  #INDEX
  @lenses = Lens.all()
  # binding.pry
  erb(:'lens/index')
end

post '/lenses' do
  #CREATE
  # binding.pry
  @lens = Lens.new(params)
  @lens.save()
  erb(:'lens/create')
end

get '/lenses/:id' do
  #SHOW
  @lens = Lens.find(params[:id]) #dynamic
  # binding.pry
  erb(:'lens/show')
end

get '/lenses/:id/edit' do
  #EDIT
  @lens = Lens.find(params[:id])
  erb(:'lens/edit')
end

put '/lenses/:id' do
  #UPDATE
  @lens = Lens.update(params)
  # binding.pry
  redirect to("/lenses/#{params[:id]}")
end

delete '/lenses/:id' do
  #DELETE
  Lens.destroy(params[:id])
  redirect to('/lenses')
end
