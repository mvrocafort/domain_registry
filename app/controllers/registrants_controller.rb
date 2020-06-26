class RegistrantsController < ApplicationController
  before_action :set_registrant, only: [:show, :edit, :update, :destroy]

  # GET /registrants
  # GET /registrants.json
  def index
    @registrants = Registrant.all
  end

  # GET /registrants/1
  # GET /registrants/1.json
  def show
  end

  # GET /registrants/new
  def new
    @registrant = Registrant.new
  end

  # GET /registrants/1/edit
  def edit
  end

  # POST /registrants
  # POST /registrants.json
  def create
    @timestamp = '%10.6f' % Time.now.to_f
    @handle = @timestamp.sub('.', '')

    @registrant = Registrant.new(registrant_params)
    @build_detail_temp = @registrant.build_detail(registrant_params[:detail_attributes])

    @registrant.handle = @handle

    # raise @reg_temp.inspect
    @order = Order.create(user_id:current_user.id)
        @order.save

    # @domain = current_user.domains.new(domain_params)
    @build_domain_temp = @registrant.build_domain(registrant_params[:domain_attributes])

    @build_domain_temp.user_id = current_user.id
    @build_domain_temp.registrant_id = @registrant.id
    @build_domain_temp.order_id = @order.id

    respond_to do |format|
      if @registrant.save
        @build_detail_temp.save
        @build_domain_temp.save

        format.html { redirect_to domains_path, notice: 'Registrant was successfully created.' }
        format.json { render :show, status: :created, location: @registrant }
      else
        format.html { render :new }
        format.json { render json: @registrant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registrants/1
  # PATCH/PUT /registrants/1.json
  def update
    respond_to do |format|
      if @registrant.update(registrant_params)
        format.html { redirect_to @registrant, notice: 'Registrant was successfully updated.' }
        format.json { render :show, status: :ok, location: @registrant }
      else
        format.html { render :edit }
        format.json { render json: @registrant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrants/1
  # DELETE /registrants/1.json
  def destroy
    @registrant.destroy
    respond_to do |format|
      format.html { redirect_to registrants_url, notice: 'Registrant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registrant
      @registrant = Registrant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def registrant_params
      params.require(:registrant).permit(
        :handle,
        detail_attributes: [
          :first_name, :last_name, :organization, :contact_number, :address
        ],
        domain_attributes: [
          :domain_name, 
          :period, 
          :registration_date, 
          :expiration_date,
          :handle
        ]
      )
    end
end

