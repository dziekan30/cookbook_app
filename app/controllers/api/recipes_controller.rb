class Api::RecipesController < ApplicationController

  def index
    search_term = params[:search]
    @recipes = Recipe.all

      if search_term
        @recipes = @recipes.where("title iLIKE ? OR ingredients iLIKE ?", "%#{ search_term }%", "%#{ search_term }%")
      end

      @recipes = @recipes.order(id: :asc)

      render 'index.json.jb'
  end
  
  def create
    
    @recipe = Recipe.new(
                          user_id: 1 ,#  current_user.id,
                          title: params[:title],
                          ingredients: params[:ingredients],
                          directions: params[:directions],
                          prep_time: params[:prep_time],
                          image_url: params[:image_url]
                          )

    @recipe.save
    render "show.json.jb"
  end

  def show
 
      @recipe = Recipe.find(params[:id])
      render "show.json.jb"

  end

  def update
    @recipe = Recipe.find(params[:id])

    @recipe.title =params[:title] || @recipe.title
    # @recipe.chef =params[:chef] || @recipe.chef
    @recipe.directions =params[:directions] || @recipe.directions
    @recipe.ingredients =params[:ingredients] || @recipe.ingredients
    @recipe.prep_time =params[:prep_time] || @recipe.prep_time
    @recipe.image_url =params[:image_url] || @recipe.image_url

    @recipe.save
    render "show.json.jb"
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy

    render json: {message: "Recipe successfully destroyed"}
  end
end
