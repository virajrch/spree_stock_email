class Spree::StockEmailsController < Spree::StoreController

  def create
    product = Spree::Product.find_by_id(params[:stock_email][:product])
    stock_email = Spree::StockEmail.new
    stock_email.email = params[:stock_email][:email]
    stock_email.product = product

    begin
      stock_email.save! unless stock_email.email_exists?
      flash[:success] = Spree.t("stock_email.notice.success")
    rescue => e
      flash[:notice] = Spree.t("stock_email.notice.error")
    end

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { render json: { message: flash[:success] || flash[:notice] }, status: flash[:success] ? 200 : 400 }
      format.js
    end
  end

end
