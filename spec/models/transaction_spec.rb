require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) {create(:user)}
  let(:agency){create(:agency)}
  let(:account) {
    Account.create(
      attributes_for(:account).merge(
        agency_id: agency.id, user_id: user.id
      )
    )
  }
  let(:second_account) {
    Account.create(
      attributes_for(:account).merge(
        number: "11111", agency_id: agency.id, user_id: user.id
      )
    )
  }  

  subject(:transaction) {
    Transaction.new(
      attributes_for(:transaction).merge( 
        destination_account_id: account.id, user_id: user.id
      )
    )
  }

  context "Success" do

    it "is valid with valid attributes" do
      expect(transaction).to be_valid
    end

    it "save when type is withdrawal" do
      transaction.origin_account_id = second_account.id
      transaction.transaction_type = 1
      transaction.save!
      expect(transaction.origin_account_id).to eq(second_account.id)
    end

    it "save when type is deposit" do
      transaction.save!
      expect(transaction.destination_account_id).to eq(account.id)
    end

    it "save when type is transfer" do
      transaction.origin_account_id = second_account.id
      transaction.transaction_type = 2
      transaction.save!
      expect(transaction.origin_account_id).to eq(second_account.id)
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
