class Account < ApplicationRecord
  
  number_regex = /\A\d+\z/

  validates :number     ,presence: true,
    uniqueness: true, 
    format: { with: number_regex, message: "Apenas números." }
  validates :limit      ,presence: true,
    format: { with: number_regex, message: "Apenas números." }
  validates :user_id    ,presence: true

  belongs_to :user
  belongs_to :agency

  has_many :destiny_transactions, class_name: "Transaction"
  has_many :origin_transactions,  class_name: "Transaction"

end