class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer     :transaction_type
      t.string      :amount_in_cents
      t.string      :date
      t.integer     :origin_account_id
      t.integer     :destination_account_id
      t.integer     :user_id
      t.timestamps
    end
  end
end
