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
subjects = ['Accounting', 'Biochemistry', 'Biology', 'Business', 'Chemistry', 'Computer Science', 'Economics', 'English', 'Finance', 
            'Histroy', 'Marketing', 'Math', 'Nutrition', 'Physics', 'Psychology', 'Spanish', 'Others']

subjects.each do |subject|
  Subject.create!(name: subject)
end

# Create Courses
courses = ['ACC 201', 'ACC 202', 'ACC 301', 'ACC 302', 'BIO 101', 'BIO 102', 'BIO 120', 'BIO 202', 'BIO 203', 
           'CSC 121', 'CSC 221', 'CSC 217', 'CSC 223', 'CSC 319', 'CSC 321', 'FIN 350', 'FIN355', 'MAT 101',
           'MAT 221', 'MAT 222', 'MAT 225', 'ENG 101']

courses.each do |course|
  Course.create!(name: course)
end










































