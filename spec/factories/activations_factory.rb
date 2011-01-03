Factory.define :activation do |f|
  f.email {Faker::Internet.email}
  f.activated false
end