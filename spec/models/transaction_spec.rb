require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) {create(:user)}
  let(:account) {create(:agency)}
  subject(:transaction) {Transaction.new(attributes_for(:transaction).merge(
    destination_account_id: account.id, user_id: user.id
  ))}

  context "Success" do

    it "is valid with valid attributes" do
      expect(transaction).to be_valid
    end

    it "return origin_account_id after save" do
      transaction.origin_account_id = account.id
      transaction.transaction_type = 1
      transaction.save!
      expect(transaction.origin_account_id).to eq(account.id)
    end

    it "return destination_account_id after save" do
      transaction.save!
      expect(transaction.destination_account_id).to eq(account.id)
    end

  end

  context "Failure" do

    it "is invalid with nil type" do
      transaction.transaction_type = nil
      expect(transaction).to be_invalid
    end

    it "is invalid with nil amount_in_cents" do
      transaction.amount_in_cents = nil
      expect(transaction).to be_invalid
    end    

    it "is invalid with nil user_id" do
      transaction.user_id = nil
      expect(transaction).to be_invalid
    end

    it "is invalid with nil date" do
      transaction.date = nil
      expect(transaction).to be_invalid
    end    
  end
end
