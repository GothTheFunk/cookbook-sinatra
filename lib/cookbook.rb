require "csv"
require_relative "recipe"

class Cookbook
  def initialize(filepath = nil)
    @recipes = []
    @filepath = filepath
    load unless @filepath == nil
  end

  def all
    @recipes
  end

  def find(index)
    @recipes[index]
  end

  def add_recipe(recipe)
    @recipes << recipe
    save unless @filepath == nil
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save unless @filepath == nil
  end

  def update
    save
  end

  private

  def load
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      row[:done] = false if row[:done] == "false"
      @recipes << Recipe.new(row)
    end
  end

  def save
    CSV.open(@filepath, "wb") do |csv|
      csv << ["name", "description", "rating", "preptime", "done"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.preptime, recipe.done]
      end
    end
  end
end
