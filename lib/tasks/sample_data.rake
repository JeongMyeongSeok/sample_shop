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
  Product.create!(name: "Harry Potter and the Sorcerer's Stone",
                  price: 2000, stock: 100,
                  picture: "http://ecx.images-amazon.com/images/I/51MU5VilKpL._SX338_BO1,204,203,200_.jpg")
  Product.create!(name: "Rubyによるクローラー開発技法",
                  price: 3000, stock: 100,
                  picture: "http://ecx.images-amazon.com/images/I/51qDobozaNL._SX349_BO1,204,203,200_.jpg")
  Product.create!(name: "Harry Potter and the Deathly Hallows",
                  price: 1500, stock: 100,
                  picture: "http://ecx.images-amazon.com/images/I/51YLjeIs-DL._SX340_BO1,204,203,200_.jpg")
  Product.create!(name: "初めてのRub",
                  price: 1000, stock: 100,
                  picture: "http://ecx.images-amazon.com/images/I/51zUT2zXuQL._SX387_BO1,204,203,200_.jpg")
end