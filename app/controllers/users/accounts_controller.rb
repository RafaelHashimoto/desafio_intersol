module Users
  class AccountsController < Users::BaseController

    before_action :set_account, except:[:index, :new, :create]
    before_action :authenticate_user!
    respond_to :js, except:[:index, :show, :destroy]
    set_tab :accounts
    
    def index
      @accounts = Account.all
    end

    def new
      @account = Account.new
    end

    def create
      @account = Account.new(account_params.merge(user_id: current_user.id))
      if @account.save
        @accounts = Account.all
        respond_to :js
      else
        respond_to :js
      end
    end

    def show
      #@accounts = @account.transactions.where(user_id: current_user)
    end 

    def edit
    end 

    def update 
      @account.update_attributes(account_params)
    end 

    def destroy
      @account.delete
      redirect_to users_accounts_path(), notice: "Conta deletada com sucesso"
    end

    private
    def set_account
      @account = Account.find(params[:id])
    end

    def account_params
      params.require(:account).permit(
        :number, :limit, :agency_id 
      )
    end
  end
end