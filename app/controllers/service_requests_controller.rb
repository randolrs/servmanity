class ServiceRequestsController < ApplicationController
  before_action :set_service_request, only: [:show, :edit, :update, :destroy]

  # GET /service_requests
  # GET /service_requests.json
  def index
    @service_requests = ServiceRequest.all
  end

  def formatted_index

    @service_requests = ServiceRequest.all

    @navigation_title = "How Can We help?"

    @hide_footer = true

  end

  def add_tasker

    if params[:tasker_id] && params[:service_request_id]

      if User.where(:id => params[:tasker_id]).exists?

        tasker = User.find(params[:tasker_id])

        @service_request = ServiceRequest.find(params[:service_request_id])

        @service_request.update(:tasker_id => tasker.id)

        redirect_to pay_and_confirm_path(params[:service_request_id])
      else

        redirect_to root_path

      end

    else

      redirect_to root_path

    end


  end

  def pay_and_confirm

    @service_request = ServiceRequest.find(params[:service_request_id])

    @navigation_title = @service_request.service_category.name + " Request"

  end

  def confirm_payment

    redirect_to service_request_submission_confirmation_path
  end

  def confirmation

    @service_request = ServiceRequest.find(params[:service_request_id])

    @navigation_title = @service_request.service_category.name + " Request"

  end

  # GET /service_requests/1
  # GET /service_requests/1.json
  def show

    @navigation_title = "Your Request"

    @hide_footer = true

  end

  def request_details

    @navigation_title = "Service Request"

    flash[:message_at_top] = "Enter Service Request Details"

    @service_request = ServiceRequest.new

    @hide_footer = true

    if params[:service_category_url]
      
      @service_cat_url_string = params[:service_category_url]
      
      if @service_cat_url_string.length > 2

        @service_category = ServiceCategory.where(:url_name => params[:service_category_url]).last
        @navigation_title = @service_category.name + " Request"
        flash[:message_at_top] = "Enter Details for Your " + @service_category.name + " Request"
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
          
          unless current_user.address

            if @service_request.address

              current_user.update(:address => @service_request.address)

            end

          end

          unless @service_request.is_live

            format.html { redirect_to service_request_tasker_index_path(@service_request.id), notice: 'Service request was successfully created.' }
            format.json { render :show, status: :created, location: @service_request }

          else

            ##CONFIRMATION

            format.html { redirect_to service_request_submission_confirmation_path(@service_request.id), notice: 'Service request was successfully created.' }
            format.json { render :show, status: :created, location: @service_request }
          end

          
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

      @navigation_title = " Service Request"

      flash[:message_at_top] = "Select a " + @service_request.service_category.name + " Professional"

    else

      redirect_to root_path

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
      params.require(:service_request).permit(:user_id, :service_category_id, :address, :longitude, :latitude, :additional_information, :scheduled_date, :time_of_day, :scheduled_day, :city, :is_live)
    end
end
