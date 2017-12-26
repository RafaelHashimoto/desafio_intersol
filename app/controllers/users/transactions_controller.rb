module Users
  class TransactionsController < Users::BaseController

    before_action :set_transaction, except:[:index, :new, :create]
    before_action :authenticate_user!
    respond_to :js, except:[:index, :show, :destroy]
    set_tab :transactions
    
    def index
      @transactions = Transaction.where(user_id: current_user.id)
    end

    def new
      @transaction = Transaction.new
    end

    def create
      @transaction = Transaction.new(transaction_params.merge(user_id: current_user.id))
      if @transaction.save
        @transactions = Transaction.where(user_id: current_user.id)
        respond_to :js
      else
        respond_to :js
      end
    end

    def show
      #@transactions = @transaction.accounts.where(user_id: current_user)
    end 

    def edit
    end 

    def update 
      @transaction.update_attributes(transaction_params)
    end 

    def chargeback
      @transaction.transaction_type = "chargeback"
      @transaction.save
    end

    private
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(
        :transaction_type, :amount_in_cents, :date,
        :origin_account_id, :destination_account_id
      )
    end
  end
end