class ServiceRequestsController < ApplicationController
  before_action :set_service_request, only: [:show, :edit, :update, :destroy]

  # GET /service_requests
  # GET /service_requests.json
  def index
    @service_requests = ServiceRequest.all
  end

  # GET /service_requests/1
  # GET /service_requests/1.json
  def show
  end

  def request_details

    @service_request = ServiceRequest.new

    if params[:service_category_url]
      
      @service_cat_url_string = params[:service_category_url]
      
      if @service_cat_url_string.length > 2

        @service_category = ServiceCategory.where(:url_name => params[:service_category_url]).last
      
      else

        @service_category = nil
      end

    else

        @service_category = nil
    end

    @additional_information_example_text = "EXAMPLE: I need help"

  end


  # GET /service_requests/new
  def new
    @service_request = ServiceRequest.new
  end

  # GET /service_requests/1/edit
  def edit
  end

  # POST /service_requests
  # POST /service_requests.json
  def create
    
    if user_signed_in?

      @service_request = ServiceRequest.new(service_request_params)

      respond_to do |format|
        if @service_request.save

          @service_request.update(:user_id => current_user.id)

          format.html { redirect_to service_request_tasker_index_path(@service_request.id), notice: 'Service request was successfully created.' }
          format.json { render :show, status: :created, location: @service_request }
        else
          format.html { render :new }
          format.json { render json: @service_request.errors, status: :unprocessable_entity }
        end
      end

    else

      redirect_to root_path

    end

  end

  def service_request_tasker_index

    if params[:id]

      @service_request = ServiceRequest.find(params[:id])

    end

  end

  # PATCH/PUT /service_requests/1
  # PATCH/PUT /service_requests/1.json
  def update
    respond_to do |format|
      if @service_request.update(service_request_params)
        format.html { redirect_to @service_request, notice: 'Service request was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_request }
      else
        format.html { render :edit }
        format.json { render json: @service_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_requests/1
  # DELETE /service_requests/1.json
  def destroy
    @service_request.destroy
    respond_to do |format|
      format.html { redirect_to service_requests_url, notice: 'Service request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_request
      @service_request = ServiceRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_request_params
      params.require(:service_request).permit(:user_id, :service_category_id, :address, :longitude, :latitude, :additional_information, :scheduled_date)
    end
end
