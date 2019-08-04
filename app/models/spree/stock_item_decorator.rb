Spree::StockItem.class_eval do
  after_save :send_stock_emails

  def send_stock_emails
    Spree::StockEmail.notify(product) if product.in_stock?
  end
end
