class CreateAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :agencies do |t|
      t.string :bank_name
      t.string :number
      t.string :city
      t.string :state
      t.string :street_name
      t.string :building_number
      t.timestamps
    end
  end
end
