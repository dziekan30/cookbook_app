class Api::RecipesController < ApplicationController

  def one_recipe_action
    @recipe = Recipe.first
    render "one_reciepe_view.json.jb"
  end
end
