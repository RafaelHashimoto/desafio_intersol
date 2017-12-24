require 'rails_helper'
RSpec.describe Users::UsersController do
  let(:user) {create(:user)}

  describe "GET #show" do 
    context "Success" do 
      before(:each) do
        sign_in(user)
        get :show
      end
    
      it "returns all users" do
        expect(assigns[:user].id).to eq(user.id)
      end    

      it "returns 200 status code" do
        expect(response.status).to eq(200)
      end      
    end
  end
end