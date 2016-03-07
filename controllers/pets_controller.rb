require_relative('../models/pet.rb')
require_relative('../models/shop.rb')

get '/pets' do
  @pets=Pet.all()
  erb(:"pets/index")
end

post '/pets' do
  #CREATE
  @pet = Pet.new( params )
  @pet.save()
  redirect to("/shops/#{params['shop_id']}")
end

get '/pets/:id' do
  #SHOW
  @pet = Pet.find(params[:id])
  @shop = @pet.shop()
  erb :"pets/show"
end

get '/pets/:id/edit' do
  #EDIT
  @pet = Pet.find(params[:id])
  @shops = Shop.all()
  erb :"pets/edit"
end

post '/pets/:id' do
  #UPDATE
  puts "PARAMS"
  puts params
  @pet = Pet.new( params )
  puts "PET"
  puts @pet.photo
  @pet.update()
  redirect to("/shops/#{params['shop_id']}")
end

delete '/shops/:id' do
  #DELETE
end