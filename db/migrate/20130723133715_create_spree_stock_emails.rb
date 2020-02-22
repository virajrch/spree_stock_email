class CreateSpreeStockEmails < ActiveRecord::Migration[4.1]
  def change
    create_table :spree_stock_emails do |t|
      t.timestamps
      t.references :variant, null: false
      t.string :email, null: false
      t.datetime :sent_at, default: nil
    end
  end
end
