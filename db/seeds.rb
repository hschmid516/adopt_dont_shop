# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

Pet.destroy_all
Shelter.destroy_all
Application.destroy_all
PetApp.destroy_all

shelter1 = create(:shelter)
shelter2 = create(:shelter)
shelter3 = create(:shelter)

pet1 = create(:pet, shelter: shelter1)
pet2 = create(:pet, shelter: shelter1)
pet3 = create(:pet, shelter: shelter2)
pet4 = create(:pet, shelter: shelter2)
pet5 = create(:pet, shelter: shelter2)
pet6 = create(:pet, shelter: shelter3)

app1 = create(:application)
# app2 = create(:application)
# app3 = create(:application)
#
# PetApp.create!(application: app1, pet: pet1)
# PetApp.create!(application: app1, pet: pet2)
# PetApp.create!(application: app1, pet: pet3)
# PetApp.create!(application: app2, pet: pet3)
# PetApp.create!(application: app2, pet: pet4)
# PetApp.create!(application: app3, pet: pet4)
# PetApp.create!(application: app3, pet: pet5)
# PetApp.create!(application: app3, pet: pet6)
