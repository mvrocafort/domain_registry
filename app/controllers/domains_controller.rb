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
    @domain = current_user.domains.new(domain_params)

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
    host      = "172.16.46.55"
    username  = "testmrocafort"
    password  = "Password123"

    client = EPP::Client.new username, password, host

    command   = EPP::Host::Check.new params[:search]
    response  = client.check command
    check     = EPP::Host::CheckResponse.new response

    # if check.available?
    #   puts "available"
    #   @domains = Domain.search(params[:search])
    #   flash.now[:notice] = 'Domain available!'
      
    # else
    #   puts "unavailable"
    #   @domains = nil
    #   flash.now[:notice] = 'Domain unavailable!'
    # end
    @domains = current_user.domains.search(params[:search])
    #@domains = current_user.domains
    #@domains = current_user.domains.search(params[:search])
    #@domains = Domain.search(params[:search])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def domain_params
      params.require(:domain).permit(:domain_name, :period, :registration_date, :expiration_date, :search)
    end
end
