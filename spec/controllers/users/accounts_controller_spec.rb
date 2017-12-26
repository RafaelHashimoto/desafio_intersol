require 'rails_helper'
RSpec.describe Users::AccountsController, type: :controller do
  let(:user) {create(:user)}
  let(:agency) {create(:agency)}

  describe "GET #index" do 
    context "success" do
      before(:each) do
        sign_in(user)
        @account = Account.create(attributes_for(:account).merge(user_id: user.id, agency_id: agency.id))
        get :index
      end

      it "has to return all accounts" do
        expect(assigns[:accounts].size).to eq(1)
      end    

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end    
    end
  end

  describe "GET #show" do 
    before(:each) do
      sign_in(user)
      @account = Account.create(attributes_for(:account).merge(user_id: user.id, agency_id: agency.id))
      get :show, params: {id: @account.id}
    end
    context "Success" do 
      it "returns all accounts" do
        expect(assigns[:account].id).to eq(@account.id)
      end    

      it "returns 200 status code" do
        expect(response.status).to eq(200)
      end      
    end
  end

  describe "GET new" do 
    context "Success" do 
      before :each do 
        sign_in(user)
        get :new, xhr: true, format: "js"
      end

      it "returns status 200" do
        expect(response.status).to eq(204)
      end     
    end
  end

  describe "POST create" do 
    context "Success" do 
      before :each do 
        sign_in(user)
        post :create, params:{ account: attributes_for(:account).merge(user_id: user.id, agency_id: agency.id)}, xhr: true, format: "js"
      end
  
      it "returns 200 status code" do 
        expect(response.status).to eq(200)
      end

      it "returns created object" do 
        expect(assigns[:account].number).to eq("11111")
      end
    end

    context "Failure" do 
      before :each do 
        sign_in(user)
        post :create, params:{ account: {number:nil}}, xhr: true, format: "js"
      end
  
      it "returns js" do
        expect(response.content_type).to eq('text/javascript')
      end 
    end
  end

  describe "GET edit" do 
    before(:each) do
      sign_in(user)
      @account = Account.create(attributes_for(:account).merge(user_id: user.id, agency_id: agency.id))
      get :edit, params: {id: @account.id}, xhr: true
    end
    context "Success" do 
      it "returns all accounts" do
        expect(assigns[:account].id).to eq(@account.id)
      end    

      it "returns js" do
        expect(response.content_type).to eq('text/javascript')
      end 

      it "returns status 200" do
        expect(response.status).to eq(200)
      end      
    end    
  end

  describe "PUT update" do 

    context "Success" do 
      before(:each) do
        sign_in(user)
        @account = Account.create(attributes_for(:account).merge(user_id: user.id, agency_id: agency.id))
        put :update, params: {id: @account.id, account: {bank_name:"Test"}}, xhr: true, format: "js"
        @account.reload
      end
  
      it "returns js" do
        expect(response.content_type).to eq('text/javascript')
      end 

      it "returns status 200" do
        expect(response.status).to eq(200)
      end            
    end  
    context "Failure" do 
      before(:each) do
        sign_in(user)
        @account = Account.create(attributes_for(:account).merge(user_id: user.id, agency_id: agency.id))
        put :update, params: {id: @account.id, account: {bank_name: nil}}, xhr: true, format: "js"
      end
  
      it "returns js" do
        expect(response.content_type).to eq('text/javascript')
      end      
    end  

  end
  
  describe "GET destroy" do 
    
    before :each do 
      sign_in(user)
      @account = Account.create(attributes_for(:account).merge(user_id: user.id, agency_id: agency.id))
    end

    context "Success" do
      it "returns 200 status code " do
        delete :destroy, params:{id: @account.id}
        expect(Account.all.count).to eq(0)
      end
    end
  end  

end