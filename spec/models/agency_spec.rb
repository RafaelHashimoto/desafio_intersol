require 'rails_helper'

RSpec.describe Agency, type: :model do
  subject(:agency) {Agency.new(attributes_for(:agency))}

  context "Success" do

    it "is valid with valid attributes" do
      expect(agency).to be_valid
    end

  end

  context "Failure" do

    it "is invalid with nil bank_name" do
      agency.bank_name = nil
      expect(agency).to be_invalid
    end

    it "is invalid with number in bank_name" do
      agency.bank_name = 88
      expect(agency).to be_invalid
    end    

    it "is invalid with nil number" do
      agency.number = nil
      expect(agency).to be_invalid
    end

    it "is invalid with character in number" do
      agency.number = "aaa"
      expect(agency).to be_invalid
    end    
    
    it "is invalid with nil city" do
      agency.city = nil
      expect(agency).to be_invalid
    end 

    it "is invalid with nil state" do
      agency.state = nil
      expect(agency).to be_invalid
    end 

    it "is invalid with nil city" do
      agency.city = nil
      expect(agency).to be_invalid
    end 

    it "is invalid with nil street_name" do
      agency.street_name = nil
      expect(agency).to be_invalid
    end 
    
    it "is invalid with nil building_number" do
      agency.building_number = nil
      expect(agency).to be_invalid
    end 

  end

end
