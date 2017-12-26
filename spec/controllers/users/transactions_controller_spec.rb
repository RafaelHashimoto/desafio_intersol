require 'rails_helper'
RSpec.describe Users::TransactionsController, type: :controller do
  
  let(:user) {create(:user)}
  let(:agency){create(:agency)}
  let(:account){ Account.create(
    attributes_for(:account).merge(user_id: user.id, agency_id: agency.id)
  )}
  describe "GET #index" do 
    context "success" do
      before(:each) do
        sign_in(user)
        @transaction = Transaction.create(attributes_for(:transaction).merge(
          user_id: user.id, destination_account_id: account.id
        ))
        get :index
      end

      it "has to return all agencys" do
        expect(assigns[:transactions].size).to eq(1)
      end    

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end    
    end
  end

  describe "GET #show" do 
    before(:each) do
      sign_in(user)
      @transaction = Transaction.create(attributes_for(:transaction).merge(
        user_id: user.id, destination_account_id: account.id         
      ))
      get :show, params: {id: @transaction.id}
    end
    context "Success" do 
      it "returns all agencys" do
        expect(assigns[:transaction].id).to eq(@transaction.id)
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
        post :create, params:{ transaction: attributes_for(:transaction).merge(
          user_id: user.id, destination_account_id: account.id
        )}, xhr: true, format: "js"
      end
  
      it "returns 200 status code" do 
        expect(response.status).to eq(200)
      end

      it "returns created object" do 
        expect(assigns[:transaction].amount_in_cents).to eq("100000")
      end
    end

    context "Failure" do 
      before :each do 
        sign_in(user)
        post :create, params:{ transaction: {amount_in_cents:nil}}, xhr: true, format: "js"
      end
  
      it "returns js" do
        expect(response.content_type).to eq('text/javascript')
      end 
    end
  end

  describe "GET edit" do 
    before(:each) do
      sign_in(user)
      @transaction = Transaction.create(attributes_for(:transaction).merge(
          user_id: user.id, destination_account_id: account.id         
      ))
      get :edit, params: {id: @transaction.id}, xhr: true
    end
    context "Success" do 
      it "returns all agencys" do
        expect(assigns[:transaction].id).to eq(@transaction.id)
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
        @transaction = Transaction.create(attributes_for(:transaction).merge(
          user_id: user.id, destination_account_id: account.id         
        ))
        put :update, params: {id: @transaction.id, transaction: {bank_name:"Test"}}, xhr: true, format: "js"
        @transaction.reload
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
        @transaction = Transaction.create(attributes_for(:transaction).merge(
          user_id: user.id, destination_account_id: account.id         
        ))
        put :update, params: {id: @transaction.id, transaction: {bank_name: nil}}, xhr: true, format: "js"
      end
  
      it "returns js" do
        expect(response.content_type).to eq('text/javascript')
      end      
    end  

  end
  
  describe "GET chargeback" do 
    
    before :each do 
      sign_in(user)
      @transaction = Transaction.create(attributes_for(:transaction).merge(
        user_id: user.id, destination_account_id: account.id
      ))
      get :chargeback, params:{id: @transaction.id}, xhr: true, format: "js"
      @transaction.reload
    end

    context "Success" do
      it "returns 200 status code " do
        
        expect(@transaction.chargeback?).to eq(true)
      end
    end
  end  

end