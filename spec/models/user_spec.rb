require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) {User.new(attributes_for(:user))}

  context "Success" do

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "returns user full name" do
      expect(user.full_name).to eq("#{user.first_name} #{user.last_name}")
    end

  end

  context "Failure" do
    
    it "is invalid with nil email" do
      user.email = nil
      expect(user).to be_invalid
    end  

    it "is invalid with nil first_name" do
      user.first_name = nil
      expect(user).to be_invalid
    end 
       
    it "is invalid if first name is too long" do
      user.first_name = 'a'*25
      expect(user).to be_invalid
    end

    it "is invalid with nil last_name" do
      user.last_name = nil
      expect(user).to be_invalid
    end 

    it "is invalid if last name is too long" do
      user.last_name = 'a'*30
      expect(user).to be_invalid
    end        

    it "is invalid with nil password" do
      user.password = nil
      expect(user).to be_invalid
    end  

  end

end
