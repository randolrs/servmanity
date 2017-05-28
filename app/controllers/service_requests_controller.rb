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

    if user_signed_in?

      if params[:tasker_id] && params[:service_request_id]

        if User.where(:id => params[:tasker_id]).exists?

          tasker = User.find(params[:tasker_id])

          @service_request = ServiceRequest.find(params[:service_request_id])

          @service_request.update(:tasker_id => tasker.id)

          unless @service_request.is_live
            
            @service_request.update(:tasker_hourly_rate => @service_request.tasker.hourly_rate_for_category(@service_request.service_category_id))

          end

          redirect_to service_request_submission_confirmation_path(@service_request.id)
          
        else

          redirect_to root_path

        end

      else

        redirect_to root_path

      end

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

    #@navigation_title = @service_request.service_category.name + " Request"

  end

  # GET /service_requests/1
  # GET /service_requests/1.json
  def show

    @navigation_title = "Your Request"

    @hide_footer = true

  end

  def review_details

    if params[:service_request_id]

      @service_request = ServiceRequest.where(:id => params[:service_request_id]).last

      unless @service_request

        redirect_to :back

      end

    else

      redirect_to :back

    end

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




  def live_request_details

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




  def scheduled_request_details

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
                    
          unless current_user.address #SAVE ADDRESS IF USER DOES NOT HAVE ONE

            if @service_request.address

              current_user.update(:address => @service_request.address)

            end

          end

          unless current_user.contact_phone_number #SAVE PHONE NUMBER IF USER DOES NOT HAVE ONE

            if @service_request.contact_phone_number

              current_user.update(:contact_phone_number => @service_request.contact_phone_number)

            end

          end

          
          #see if saved payments selected

          if params[:payment_option] == "saved"
                      
            customer = current_user.stripe_customer_object
            
          else

            #CREATE STRIPE CARD TOKEN

            token = Stripe::Token.create(

              :card => {
                :number => params[:creditCardNumber],
                :exp_month => params[:expMonth],
                :exp_year => params[:expYear],
                :cvc => params[:cvc]

              },
            )

            customer = current_user.stripe_customer_object

            unless customer #does user have stripe customer?

              customer = Stripe::Customer.create(
              
                :card  => token.id

              )

              UserStripeCustomer.create(:user_id => current_user.id, :stripe_customer_id => customer.id)
            
            else

              customer.sources.create(source: token.id)

            end

          end

          @service_request.update(:stripe_customer_id => customer.id)

          #END STRIPE TOKEN CREATE


          if @service_request.is_live #if this is a ASAP request

            format.html { redirect_to service_request_live_search_path(@service_request.id), notice: 'Service request was successfully created.' }
            format.json { render :show, status: :created, location: @service_request }

          else #if this is a scheduled request


            format.html { redirect_to service_request_tasker_index_path(@service_request.id), notice: 'Service request was successfully created.' }
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

  rescue Stripe::CardError => e
    flash[:error] = e.message
    #redirect_to root_path(@service_request.id) and return
    redirect_to root_path and return
  end


  def mark_as_complete

    if params[:service_request_id]

      @service_request = ServiceRequest.where(:id => params[:service_request_id]).last

      if @service_request

        if current_user.is_tasker
          
          @service_request.update(:is_complete_tasker => true, :tasker_completion_time => Time.now)

        else

          @service_request.update(:is_complete_user => true)

        end

        redirect_to service_request_confirm_complete_path(@service_request.id)

      else

        root_path

      end

    else

      redirect_to root_path

    end

  end


  def mark_as_cancelled

    if params[:service_request_id]

      @service_request = ServiceRequest.where(:id => params[:service_request_id]).last

      if @service_request

        if @service_request.user_id == current_user.id || current_user.is_admin

          @service_request.update(:is_cancelled => true)

          redirect_to service_request_confirm_cancelled_path(@service_request.id)

        else

          if @service_request.tasker_id == current_user.id

            @service_request.update(:tasker_id => nil)

            redirect_to service_request_confirm_cancelled_path(@service_request.id)

          else

            redirect_to root_path

          end

        end


      else

        redirect_to root_path

      end


    else

      redirect_to root_path

    end

  end

  def service_request_confirm_cancelled

    if params[:service_request_id]

      @service_request = ServiceRequest.where(:id => params[:service_request_id]).last

      if @service_request

      else

        redirect_to root_path

      end


    else

      redirect_to root_path

    end

  end

  def service_request_confirm_complete

    if params[:service_request_id]

      @service_request = ServiceRequest.where(:id => params[:service_request_id]).last

      if @service_request

      else

        redirect_to root_path

      end


    else

      redirect_to root_path

    end


  end

  def admin_process_payment

    if user_signed_in?

      if current_user.is_admin

        if params[:service_request_id]

          service_request = ServiceRequest.where(:id => params[:service_request_id]).last

            if service_request

              if service_request.is_live

                price = (service_request.price * 100).to_i

              else

                price = (service_request.calculated_price_for_scheduled * 100).to_i

              end

              platform_fee = (price * 0.08).to_i

              #CREATE TASKER ACCOUNT IF NECESSARY
              tasker = service_request.tasker

              if tasker

                unless tasker.stripe_account_id

                  account = Stripe::Account.create({:country => "US", :type => "custom"})

                  tasker.update(:stripe_account_id => account.id, :stripe_secret_key => account.keys.secret, :stripe_publishable_key => account.keys.publishable)

                  account.tos_acceptance.date = Time.now.to_i

                  account.tos_acceptance.ip = request.remote_ip

                  account.legal_entity.type = "individual"

                  account.save

                end

              end

              #Stripe.api_key = tasker.stripe_secret_key

              charge = Stripe::Charge.create(
                :customer    => service_request.stripe_customer_id,
                :amount      => price,
                :description => 'Rails Stripe customer',
                :currency    => 'usd',
                :destination => tasker.stripe_account_id,
                :application_fee => platform_fee
              )

              Charge.create(:user_id => service_request.user_id, :tasker_id => service_request.tasker_id, :stripe_customer_id => service_request.stripe_customer_id, :destination_stripe_account_id => service_request.tasker.stripe_account_id, :amount => price, :service_fee => platform_fee)

              service_request.update(:charge_approved => true)

              Stripe.api_key = ENV['STRIPE_TEST_SECRET_KEY']

              redirect_to :back


            else

              redirect_to :back

            end

        else

          redirect_to root_path

        end

      else

        redirect_to root_path

      end

    else

      redirect_to root_path

    end


 rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to :back
  end


  def live_search

    @hide_footer = true

  end

  def check_for_acceptance

    @service_request = ServiceRequest.find(params[:requestID])

    if @service_request
        
      render json: { :result => "success", :accepted => !(@service_request.tasker_id.nil?), :redirect_to_url => service_request_submission_confirmation_path(@service_request.id), content_type: 'text/json' }
      
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
      params.require(:service_request).permit(:user_id, :service_category_id, :address, :longitude, :latitude, :additional_information, :scheduled_date, :time_of_day, :scheduled_day, :city, :is_live, :description, :price, :contact_phone_number, :hours_reported_by_tasker)
    end
end
