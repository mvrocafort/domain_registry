class DomainsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_domain, only: [:show, :edit, :update, :destroy]

  # GET /domains
  # GET /domains.json
  def index
    @domains = Domain.all
  end

  # GET /domains/1
  # GET /domains/1.json
  def show
  end


  # GET /domains/new
  def new
    @domain = Domain.new
  end

  # GET /domains/1/edit
  def edit
  end

  # POST /domains
  # POST /domains.json
  def create
    # create registrant -> create order -> create domain
    @order = Order.create(user_id:current_user.id)
    @order.save

    if @order.save
      puts "order created with id #{@order.id}"
    else
      puts 'order creation failed'
    end

    @domain = current_user.domains.new(domain_params)

    @domain.user_id = current_user.id
    @domain.registrant_id = Registrant.last.id
    @domain.order_id = @order.id

    # create an order first
    respond_to do |format|
      if @domain.save
        format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
        format.json { render :show, status: :created, location: @domain }
      else
        format.html { render :new }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /domains/1
  # PATCH/PUT /domains/1.json
  def update
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
        format.json { render :show, status: :ok, location: @domain }
      else
        format.html { render :edit }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    @domain.destroy
    respond_to do |format|
      format.html { redirect_to domains_url, notice: 'Domain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    #insert input validation here
  end

  def result
    @renew_flag = false
    @available_flag = false

    if current_user.domains.search(params[:search]) != nil #there are domains available for renewal for current user
      @domains = current_user.domains.search(params[:search]) #return domains of user
      @renew_flag = true
    else #no registered domains under current user, check in epp if available
          @domains = Domain.search(params[:search])
          flash.now[:notice] = 'Domain available!'
          @available_flag = true

          #temp variable to pass input to register model
          @search_temp = params[:search]

      		# host      = "172.16.46.55"
          # username  = "testmrocafort"
          # password  = "Password123"
        
          # client = EPP::Client.new username, password, host
        
          # #epp checker for domain availability
          # command   = EPP::Domain::Check.new(params[:search])
          # response  = client.check command
          # check     = EPP::Domain::CheckResponse.new response
        
          # if check.available? #if available, show register link to user (use a flag to be used in view)
          #   @domains = Domain.search(params[:search])
          #   flash.now[:notice] = 'Domain available!'
          #   @available_flag = true

          #   #temp variable to pass input to register model
          #   @search_temp = params[:search]
          # else #if not available, do nothing
          #   redirect_to '/'
          #   flash[:notice] = 'Domain unavailable!'
          # end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def domain_params
      params.require(:domain).permit(
        :domain_name, 
        :period, 
        :registration_date, 
        :expiration_date,
        :handle, 
        :search,
        domain_price_attributes: [
          :id,
          :price,
          :price_cents,
          :price_currency
        ]
      )
    end
end
