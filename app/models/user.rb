class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name,  presence: true, length:{maximum:15}
  validates :last_name,   presence: true, length:{maximum:25}

  has_many :accounts
  has_many :transactions
  
  def full_name
    "#{first_name} #{last_name}".strip
  end
end
