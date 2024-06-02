class CreateBillings < ActiveRecord::Migration[7.1]
  def change
    create_table :billings do |t|
      t.date :emission
      t.date :expire
      t.string :identification
      t.integer :amount
      t.integer :status, default: 0
      t.integer :category

      t.timestamps
    end
  end
end
