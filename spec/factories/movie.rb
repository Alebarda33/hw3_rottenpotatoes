FactoryGirl.define do
  factory :movie do
    title 'A Fake Title' #default value
    rating 'PG'
    release_date {10.years.ago}
    director 'A Fake Director'
  end
end

