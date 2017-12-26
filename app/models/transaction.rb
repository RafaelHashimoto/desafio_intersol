class Transaction < ApplicationRecord

  before_destroy false

  validates  :type        , presence: true
  validates  :amount      , presence: true
  validates  :date        , presence: true
  validates  :account_id  , presence: true
  validates  :user_id     , presence: true

  belongs_to :account
  belongs_to :user
end