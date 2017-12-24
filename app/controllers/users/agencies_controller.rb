module Users
  class AgenciesController < Users::BaseController

    before_action :set_agency, except:[:index, :new, :create]
    before_action :authenticate_user!
    respond_to :js, except:[:index, :show, :destroy]
    set_tab :agencies
    
    def index
      @agencies = Agency.all
    end

    def new
      @agency = Agency.new
    end

    def create
      @agency = Agency.new(agency_params)
      if @agency.save
        @agencies = Agency.all
        respond_to :js
      else
        respond_to :js
      end
    end

    def show
      @accounts = @agency.accounts.where(user_id: current_user)
    end 

    def edit
    end 

    def update 
      @agency.update_attributes(agency_params)
    end 

    def destroy
      @agency.delete
      redirect_to users_agencies_path(), notice: "Conta deletada com sucesso"
    end

    private
    def set_agency
      @agency = Agency.find(params[:id])
    end

    def agency_params
      params.require(:agency).permit(
        :bank_name, :number, :state,       
        :city, :street_name, :building_number
      )
    end
  end
end