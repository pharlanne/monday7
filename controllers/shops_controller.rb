require_relative('../models/shop.rb')

get '/shops' do
  #INDEX
  @shops = Shop.all()
  erb :"shops/index"
end

get '/shops/new' do
  #NEW
  erb :"shops/new"
end

post '/shops' do
  #CREATE
  @shop = Shop.new( params )
  @shop.save()
  redirect '/shops'
end

get '/shops/:id' do
  #SHOW
  @shop = Shop.find(params[:id])
  @pets = @shop.pets()
  erb :"shops/show"
end

get '/shops/:id/edit' do
  #EDIT
  @shop= Shop.find(params[:id])
  erb :"shops/edit"
end

post '/shops/:id' do
  #UPDATE
  @shop = Shop.new( params )
  @shop.update()
  redirect to("/shops/#{params['id']}")
end

  post'/shops/:id/delete'do
  #DELETE
  Shop.destroy(params[:id])
  redirect to("/shops")
end
