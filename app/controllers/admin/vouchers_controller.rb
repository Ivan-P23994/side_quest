class Admin::VouchersController < ApplicationController
  def new
    set_voucher_types
    @voucher = Voucher.new
  end

  def create
    @voucher = Voucher.new(voucher_params)
    amount = [ params[:voucher][:amount].to_i ]
    ids = [ (Voucher.maximum(:id) || 0) + 1 ]
    tx_hash = ContractServices::MintVouchersBatchService.new.call(ids, amount) if @voucher.valid?

    @voucher.transaction_hash = tx_hash
    @voucher.redeemed = false

    respond_to do |format|
      if @voucher.save
        format.turbo_stream
      else
        render turbo_stream: turbo_stream.prepend(
          "flash-messages",
          partial: "shared/alert",
          locals: { message: "Voucher creation failed" }
        )
      end
    end
  end

  private

  def voucher_params
    params.require(:voucher).permit(:title, :description, :transaction_hash, :voucher_type_id, :owner_id, :redeemed)
  end

  def set_voucher_types
    @voucher_types = VoucherType.all
  end
end
