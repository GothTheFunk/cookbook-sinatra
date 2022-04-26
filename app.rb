require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "lib/cookbook.rb"
require_relative "lib/recipe.rb"
filepath = "lib/cookbook.csv"
cookbook = Cookbook.new(filepath)


configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get "/" do
  @list = cookbook.all
  erb :index
end

get "/about" do
  erb :about
end

get "/new" do
   erb :new
end

post "/recipe" do
    name = params[:name]
    description = params[:description]
    rating = params[:rating]
    new_recipe = Recipe.new(name: params["name"], description: params["description"], rating: rating, preptime: "unknown", done: false)
    cookbook.add_recipe(new_recipe)
    redirect to("/")
end
