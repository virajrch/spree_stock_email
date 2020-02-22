class AddIndexToSpreeStockEmails < ActiveRecord::Migration[4.1]
  def change
    add_index :spree_stock_emails, [:sent_at, :variant_id, :email]
  end
end
