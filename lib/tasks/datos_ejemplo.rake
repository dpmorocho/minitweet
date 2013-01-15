#namespace :db do
#desc "Fill database with sample data"
#	task populate: :environment do
#	    User.create!(name: "Usuario Ejemplo", email: "ejemplo@ejemplo.org", password: "abcdef", password_confirmation: "abcdef") 99.times do |n|
#	    	name  = Faker::Name.name
#	    	email = "ejemplo-#{n+1}@ejemplo.org"
#	    	password = "password"
#			User.create!(name: name, email: email, password: password, password_confirmation: password )
#		end
#	end
#end
namespace :db do
  desc ""
  task populate: :environment do
    #User.create!(:name => "Diego Morocho",
       #          :email => "dpmorocho@gmail.com",
      #           :password => "dpmorocho",
     #            :password_confirmation => "dpmorocho")
    #admin.toggle!(:admin)
    0.times do |n|
      name  = Faker::Name.name
      email = "ejemplo-#{n+1}@ejemplo.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end