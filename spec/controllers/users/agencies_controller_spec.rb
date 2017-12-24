require 'rails_helper'
RSpec.describe Users::AgenciesController, type: :controller do
  let(:user) {create(:user)}

  describe "GET #index" do 
    context "success" do
      before(:each) do
        sign_in(user)
        @agency = Agency.create(attributes_for(:agency))
        get :index
      end

      it "has to return all agencys" do
        expect(assigns[:agencies].size).to eq(1)
      end    

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end    
    end
  end

  describe "GET #show" do 
    before(:each) do
      sign_in(user)
      @agency = Agency.create(attributes_for(:agency))
      get :show, params: {id: @agency.id}
    end
    context "Success" do 
      it "returns all agencys" do
        expect(assigns[:agency].id).to eq(@agency.id)
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
        post :create, params:{ agency: attributes_for(:agency)}, xhr: true, format: "js"
      end
  
      it "returns 200 status code" do 
        expect(response.status).to eq(200)
      end

      it "returns created object" do 
        expect(assigns[:agency].bank_name).to eq("Bradesco")
      end
    end

    context "Failure" do 
      before :each do 
        sign_in(user)
        post :create, params:{ agency: {bank_name:nil}}, xhr: true, format: "js"
      end
  
      it "returns js" do
        expect(response.content_type).to eq('text/javascript')
      end 
    end
  end

  describe "GET edit" do 
    before(:each) do
      sign_in(user)
      @agency = Agency.create(attributes_for(:agency))
      get :edit, params: {id: @agency.id}, xhr: true
    end
    context "Success" do 
      it "returns all agencys" do
        expect(assigns[:agency].id).to eq(@agency.id)
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
        @agency = Agency.create(attributes_for(:agency))
        put :update, params: {id: @agency.id, agency: {bank_name:"Test"}}, xhr: true, format: "js"
        @agency.reload
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
        @agency = Agency.create(attributes_for(:agency))
        put :update, params: {id: @agency.id, agency: {bank_name: nil}}, xhr: true, format: "js"
      end
  
      it "returns js" do
        expect(response.content_type).to eq('text/javascript')
      end      
    end  

  end
  
  describe "GET destroy" do 
    
    before :each do 
      sign_in(user)
      @agency = Agency.create(attributes_for(:agency))
    end

    context "Success" do
      it "returns 200 status code " do
        delete :destroy, params:{id: @agency.id}
        expect(Agency.all.count).to eq(0)
      end
    end
  end  

end