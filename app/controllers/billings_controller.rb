class BillingsController < ApplicationController
  before_action :check_expired_billings, only: :dashboard

  def dashboard 
    @expireds = Billing.expireds
    @to_expire = Billing.to_expire
    @latests = Billing.order(created_at: :desc).limit(5)
  end

  def show 
    @billing = Billing.find(params[:id])
    @billing.expire_date_check
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

  def check_expired_billings
    opens = Billing.where(status: 'open')
    opens.each do |billing|
      billing.expire_date_check
    end
  end
end