class Admin::VoucherTypesController < ApplicationController
  def new
    @voucher_type = VoucherType.new
  end

  def create
    @voucher_type = VoucherType.new(voucher_type_params)
    tx_hash = ContractServices::CreateVoucherTypeService.new.call(@voucher_type.title) if @voucher_type.valid?
    @voucher_type.transaction_hash = tx_hash


    respond_to do |format|
      if @voucher_type.save
        format.turbo_stream
      else
        render turbo_stream: turbo_stream.prepend(
          "flash-messages",
          partial: "shared/alert",
          locals: { message: "Voucher Type creation failed" }
        )
      end
    end
  end

  private

  def voucher_type_params
    params.require(:voucher_type).permit(:title, :description, :transaction_hash)
  end
end
