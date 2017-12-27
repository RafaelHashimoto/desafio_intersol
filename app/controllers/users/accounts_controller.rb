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
      @amount = 0
      @account_transactions = Transaction.where(
        origin_account_id: @account.id).or(Transaction.where(
          destination_account_id: @account.id
        )
      )
      @amount = set_amount(@amount, @account_transactions)
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

    def set_amount(amount, transactions)
      transactions.each do |transaction|
        if transaction.deposit? || (transaction.transfer? && transaction.destination_account == @account) 
         amount += transaction.amount_in_cents.to_i  
        elsif transaction.withdrawal? || (transaction.transfer? && transaction.origin_account == @account) 
          amount -= transaction.amount_in_cents.to_i  
        elsif transaction.chargeback?
          if (transaction.try(:origin_account) == @account) 
            amount += transaction.amount_in_cents.to_i  
          elsif (transaction.try(:destination_account) == @account) 
            amount -= transaction.amount_in_cents.to_i  
          end
        end
      end
      return amount
    end
  end
end