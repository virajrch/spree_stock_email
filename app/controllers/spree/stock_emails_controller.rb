class Spree::StockEmailsController < Spree::StoreController

  def create
    variant = Spree::Variant.find_by_id(params[:stock_email][:variant])
    stock_email = Spree::StockEmail.new
    stock_email.email = spree_current_user ? spree_current_user.email : params[:stock_email][:email]
    stock_email.variant = variant

    begin
      stock_email.save! unless stock_email.email_exists?
      flash[:success] = Spree.t("stock_email.notice.success", variant: variant.name)
    rescue => e
      flash[:notice] = Spree.t("stock_email.notice.error")
    end

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.json { render json: { message: flash[:success] || flash[:notice] }, status: flash[:success] ? 200 : 400 }
    end
  end

end
