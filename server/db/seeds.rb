# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

Activity.destroy_all
User.destroy_all
Participate.destroy_all


3.times do |n|
  user = User.create(:name => Faker::Name.name,
                     :email => Faker::Internet.email,
                     :baby_name => Faker::Name.first_name,
                     :baby_age => rand(1..8),
                     :password => 111111,
                     :avatar => Faker::Avatar.image,
                     :global_key => '',
                     :path => '',
                     :slogan => '',
                     :baby_birthday => Faker::Date.between(2.days.ago, Date.today) ,
                     :baby_hobby => Faker::Commerce.department,
                     :baby_school => Faker::Address.city,
                     :sex => rand(1..2),
                     :baby_sex => rand(1..2),
                     :introduction => Faker::Lorem.paragraph(2)
  )
  4.times do |n|
    activity = Activity.create(:title => Faker::Company.bs,
                               :description => Faker::Lorem.paragraph(2),
                               :start_time => Faker::Time.between(2.days.ago, Time.now),
                               :end_time => Faker::Time.between(2.days.ago, Time.now),
                               :created_time => Faker::Time.backward(14, :evening),
                               :updated_time => Faker::Time.backward(4, :evening) ,
                               :max_number => rand(1..10),
                               :image_url => Faker::Avatar.image,
                               :location => Faker::Address.street_name,
                               :location_longitude => Faker::Address.longitude,
                               :location_latitude => Faker::Address.latitude,
                               :acceptable => TRUE,
                               :user => user
    )

    puts activity
    activity.save!
  end
  puts user
  user.save!
end

user = User.first
activity = Activity.last
participate = Participate.create(:user => user,
                                 :activity => activity
)
put participate
participate.save

