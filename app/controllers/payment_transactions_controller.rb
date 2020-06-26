class PaymentTransactionsController < ApplicationController
    # before_action :authenticate_user!
    before_action :find_payment_transaction, except: [:index]
    def index
      @payment_transactions = current_user.payment_transactions
    end
  
  
  private
  
    def find_payment_transaction
      @payment_transaction = payment_transaction.find(params[:id])
    end
  
    def payment_transaction_params
      params.require(:payment_transaction).permit()
    end
end
