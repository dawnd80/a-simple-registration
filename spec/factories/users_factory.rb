Factory.define :user do |f|
  f.email {Faker::Internet.email}
  f.first_name {Faker::Name.first_name}
  f.last_name {Faker::Name.last_name}
  f.birthdate {rand(80).years.ago}
  f.password "12345"
  f.password_confirmation { |a| a.password }
end