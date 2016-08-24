class Cat
  attr_accessor :id, :name, :breed, :color, :age_category

  def initialize(input_options)
    @id = input_options["id"]
    @name = input_options["name"]
    @breed = input_options["breed"]
    @color = input_options["color"]
    @age_category = input_options["age_category"]
  end
end
