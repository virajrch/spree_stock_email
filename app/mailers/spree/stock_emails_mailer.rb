module Spree
  class StockEmailsMailer < Spree::BaseMailer
    default from: Spree::StockEmailConfig::Config.email_from

    def stock_email(stock_email)
      @stock_email = stock_email
      mail to: @stock_email.email, subject: Spree.t("stock_email.email.subject", product: stock_email.product.name)
    end
  end
end
