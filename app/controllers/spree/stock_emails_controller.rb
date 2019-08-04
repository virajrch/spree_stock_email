class Spree::StockEmailsController < ApplicationController

  def create
    product = Spree::Product.find_by_id(params[:stock_email][:product])
    redirect_back(fallback_location: root_path) and return unless product

    stock_email = Spree::StockEmail.new
    stock_email.email = params[:stock_email][:email]
    stock_email.product = product

    begin
      stock_email.save! unless stock_email.email_exists?
      flash[:success] = "We'll email you when #{product.name} is back in stock!"
    rescue => e
      flash[:notice] = "There was a problem setting up your email alert. Please try again."
    end

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { render json: { message: flash[:success] || flash[:notice] }, status: flash[:success] ? 200 : 400 }
      format.js
    end
  end

end
