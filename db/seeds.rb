require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

employees_json = File.read('db/seed_data/employees.json')
gifts_json = File.read('db/seed_data/gifts.json')
employees_hash = JSON.parse(employees_json)
gifts_hash = JSON.parse(gifts_json)

Employee.create!(employees_hash)
Gift.create!(gifts_hash)
