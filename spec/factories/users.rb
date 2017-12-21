FactoryBot.define do
  factory :user do
    first_name            "John"
    last_name             "Tester"
    email                 "johntester@email.com"
    password              "123123"
    password_confirmation "123123"
  end
end
