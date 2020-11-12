require 'json'
require 'open-uri'
require 'faker'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_serialized = open(url).read
ingredients = JSON.parse(ingredients_serialized)

puts 'Cleaning database ...'
Dose.destroy_all
Cocktail.destroy_all
Ingredient.destroy_all

puts 'Creating ingredients ...'
ingr = []
ingredients["drinks"].each_with_index do |ingredient, val|
  ingr << Ingredient.create!(name: ingredient['strIngredient1'])
end
puts 'Ingredients created !'


puts 'Creating cocktails ...'
cocktails = []
cocktails << Cocktail.create!(name:'Sex On The Beach')
cocktails << Cocktail.create!(name:'Piña Colada')
cocktails << Cocktail.create!(name:'Irish Coffee')
cocktails << Cocktail.create!(name:'Virgin Mojito')
cocktails << Cocktail.create!(name:'Mojito')
cocktails << Cocktail.create!(name:'Maruya')
cocktails << Cocktail.create!(name:'Whisky Coca')
puts 'Cocktails created !'

puts 'Creating doses ...'
25.times do
  dose = Dose.create!(description: Faker::Measurement.metric_volume, cocktail: cocktails.sample, ingredient: ingr.sample)
  ingr.delete(dose.ingredient)
end
puts 'Doses created!'
