FactoryBot.define do
  factory :transaction do
    amount_in_cents   "1000"
    date              "26/12/2017"
    transaction_type  "deposit"
  end
end