class Transaction < ApplicationRecord

  include EnumTranslation

  before_save :set_account
  before_destroy false

  validates :origin_account_id    ,presence: true,
     if: :validation_for_origin_account
  validates :destination_account_id   ,presence: true,
     if: :validation_for_destination_account
  validates :transaction_type  ,presence: true
  validates :amount_in_cents   ,presence: true
  validates :date              ,presence: true
  validates :user_id           ,presence: true 
  validate  :account_uniqueness
  validate  :amount_limit,  if: :validation_for_origin_account

  enum transaction_type: [:deposit, :withdrawal, :transfer, :chargeback]

  belongs_to :origin_account  , class_name: "Account",
    foreign_key: "origin_account_id", optional: true
  belongs_to :destination_account , class_name: "Account",
    foreign_key: "destination_account_id", optional: true
  belongs_to :user

  private 

  def set_account
    if  deposit? 
      origin_account_id = destination_account
    elsif withdrawal?
      origin_account_id = origin_account
    elsif transfer?
      origin_account_id = origin_account
      destination_account_id = destination_account
    end
  end

  def account_uniqueness
    if origin_account_id == destination_account_id
      errors.add(:destination_account_id, 'não pode ser igual a conta de origem')
    end
  end

  def amount_limit
    if amount_in_cents.to_i > Account.find(origin_account_id).limit.to_i
      errors.add(:amount_in_cents, 'não pode ser maior que o limite da conta')
    end
  end

  def validation_for_origin_account
    withdrawal? || transfer?
  end

  def validation_for_destination_account
    deposit? || transfer?
  end
end