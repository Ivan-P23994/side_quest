class Admin::DashboardController < ApplicationController
  def index
    @voucher_types = VoucherType.all.order(:title)
    @vouchers = Voucher.all.order(:created_at)
  end

  private

  def require_admin_key
    unless params[:admin_key].present? && params[:admin_key] == ENV["ADMIN_KEY"]
      redirect_to login_path, alert: "Unauthorized"
    end
  end
end
