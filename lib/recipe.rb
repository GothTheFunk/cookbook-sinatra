class Recipe
  attr_reader :name, :description, :preptime, :rating, :done

  def initialize(args = {})
    @name = args[:name]
    @description = args[:description]
    @rating = args[:rating]
    @preptime = args[:preptime]
    @done = args[:done]
  end

  def done?
    @done
  end

  def done!
    @done = true
  end
end
