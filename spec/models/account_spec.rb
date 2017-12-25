require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:user) {create(:user)}
  let(:agency) {create(:agency)}
  subject(:account) {Account.new(attributes_for(:account).merge(
    user_id: user.id, agency_id: agency.id
  ))}

  context "Success" do

    it "is valid with valid attributes" do
      expect(account).to be_valid
    end

  end

  context "Failure" do


    it "is invalid with nil number" do
      account.number = nil
      expect(account).to be_invalid
    end

    it "is invalid with character in number" do
      account.number = "aaa"
      expect(account).to be_invalid
    end    
    
    it "is invalid with nil limit" do
      account.limit = nil
      expect(account).to be_invalid
    end 

    it "is invalid with char in limit" do
      account.limit = "aa"
      expect(account).to be_invalid
    end 

    it "is invalid with nil user_id" do
      account.user_id = nil
      expect(account).to be_invalid
    end 
    
    it "is invalid with nil agency_id" do
      account.agency_id = nil
      expect(account).to be_invalid
    end 

  end

end
