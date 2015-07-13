namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_products
  end
end

def make_users
  User.create!(name:   "ExampleUser",
                       email:    "test@gmail.com",
                       password: "foobar",
                       password_confirmation: "foobar")
  99.times do |n|
    name  = "#{Faker::Name.first_name}#{n+2}"
    email = "example-#{n+1}@railstutorial.jp"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_products
  product_lists = { "Bread_toast" => "Bread_toasts.png", 
    "Coffee_machine" => "Coffee_machine.png", 
    "Coffee_maker" => "Coffee_maker.png", 
    "Glass" => "Glass.png", "Hamburger" => "Hamburger.png", 
    "plastic_cup" => "plastic_cup.png", "Saucepan" => "Saucepan.png",
    "Coffee_cup" => "Coffee_cup.png", "Knife" => "Knife.png"}

  product_lists.each { |key, value|
    Product.create!(name: "#{key}", price: 2000, stock: 100, picture: "#{value}")
  }
end