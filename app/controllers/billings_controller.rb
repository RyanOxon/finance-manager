class BillingsController < ApplicationController
  def dashboard; end

  def show 
    @billing = Billing.find(params[:id])
  end

  def new
    @billing = Billing.new
  end

  def create 
    @billing = Billing.new(billing_params)
    if @billing.save
      redirect_to @billing, notice: 'Duplicata registrada com sucesso'
    else
      flash.now[:alert] = 'Preencha todos os campos corretamente'
      render :new
    end
  end

  private
  def billing_params
    params.require(:billing).permit(:emission, :expire, :identification, :amount, :category)
  end
end