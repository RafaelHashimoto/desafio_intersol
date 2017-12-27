module ApplicationHelper
  
  def agencies?
    Agency.all.any?
  end

  def accounts?
    Account.where(user_id: current_user.id ).any?
  end

  def transactions?
    Transaction.where(user_id: current_user.id).any?
  end

  def options_for_transaction_type
    ['deposit', 'withdrawal', 'transfer']
  end

  def my_accounts
    Account.where(user_id: current_user.id)
  end

  def accounts
    Account.all
  end

  def transaction_amount(transaction, account)
    if transaction.deposit? || (transaction.transfer? && transaction.destination_account == account) 
      " + " + number_to_currency((transaction.amount_in_cents.to_f/100), unit: "R$") 
    elsif transaction.withdrawal? || (transaction.transfer? && transaction.origin_account == account) 
      " - " + number_to_currency((transaction.amount_in_cents.to_f/100), unit: "R$") 
    elsif transaction.chargeback?
      if (transaction.try(:origin_account) == account) 
        number_to_currency((transaction.amount_in_cents.to_f/100), unit: "R$") 
      elsif (transaction.try(:destination_account) == account) 
        number_to_currency((transaction.amount_in_cents.to_f/100), unit: "R$") 
      end
    end
  end

  def chargeback_type(transaction)
    if transaction.origin_account && transaction.destination_account
      "Est. de Transf. de: " + transaction.origin_account.to_s
    elsif transaction.origin_account && transaction.destination_account == nil
      "Estorno de Saque"
    elsif transaction.origin_account == nil && transaction.destination_account
      "Estorno de depósito"
    end
  end
  
end
