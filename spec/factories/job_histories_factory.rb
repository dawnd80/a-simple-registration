Factory.define :job_history do |f|
  f.title "Engineer"
  f.company { Faker::Company.name }
end