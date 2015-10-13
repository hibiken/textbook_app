# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#


User.create!(name:   "Michael Hartl",
            email:  "example@railstutorial.org",
            password:               "foobar",
            password_confirmation:  "foobar",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

40.times do |n|
  name = Faker::Name.name
  email = "example-#{n}@railstutorial.org"
  password = 'password'
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)  
end


# Create Subjects
subjects = ['Accounting', 'Biochemistry', 'Biology', 'Chemistry', 'Computer Science', 'Economics', 'English', 'Finance', 
            'Histroy', 'Marketing', 'Nutrition', 'Physics', 'Psychology', 'Spanish', 'Others']

subjects.each do |subject|
  Subject.create!(name: subject)
end


