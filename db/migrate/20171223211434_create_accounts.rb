class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :number
      t.string :limit
      t.string :agency_id
      t.string :user_id
      t.timestamps
    end
  end
end
