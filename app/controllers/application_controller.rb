class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true # this will tell our application to look for the _method key in params
  end

  get '/recipes' do
    #get all the recipes
    @recipes = Recipe.all
    # binding.pry
    #render view
    erb :"recipes/index"
  end

  # create a recipe
  get '/recipes/new' do
    #display form to enter a new recipe
     erb :"recipes/new"
  end

  post '/recipes' do
    # get params from recipes/new and pass them
    #create new record/instance
    @recipe = Recipe.create(params)
    # binding.pry
    # response
    redirect "/recipes/#{@recipe.id}"
  end

  #show a single recipe
  get '/recipes/:id' do
    #model
    @recipe = Recipe.find(params[:id])
    #response
    erb :"recipes/show"
  end

  #edit a recipe record
  get '/recipes/:id/edit' do
     # model
     @recipe = Recipe.find(params[:id])
    
     # response
    erb :"recipes/edit"
  end

  #this will update the record
  #make sure you have "set :method_override, true" in (configure do) up top of file
  put '/recipes/:id' do
     # find the instance of the recipe
     recipe = Recipe.find(params[:id])
    
     # perform an update on the instance using params
      # make sure it saves!
      recipe.update(params[:recipe])
      # response
    redirect "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
    #model
    recipe = Recipe.find(params[:id])
  
    recipe.destroy
    #response
    redirect "/recipes"
  end
end
