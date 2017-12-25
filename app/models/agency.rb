class Agency < ApplicationRecord
  
  char_regex = /(^[a-z ]+$)/i
  number_regex = /\A\d+\z/

  validates :bank_name      ,
   presence: true,
   format: { with: char_regex, message: "Apenas caractéres." }
  validates :number         , presence: true, 
    uniqueness: true, 
    format: { with: number_regex, message: "Apenas números." }
  validates :state          , presence: true
  validates :city           , presence: true
  validates :street_name    , presence: true
  validates :building_number, presence: true
  
  has_many :accounts

  def to_s
    bank_name + " - Ag: " + number
  end
end