class UsersController < ApplicationController
  
  def non_tasker_signup
  	@hide_header = true
    flash[:message_at_top] = "Signup for Servmanity"
  end

  def tasker_signup
  	@hide_header = true
    flash[:message_at_top] = "Signup for Servmanity"
  end

  def profile

  	if params[:id]

  		@user = User.where(:id => params[:id]).last

  		unless @user
        flash[:error_prompt] = 'Error: Cannot Find Profile'
  			redirect_to root_path

      else

        unless @user.id == current_user.id
          @navigation_title = @user.public_display_name.possessive + " Profile"
        else
          @navigation_title = "Your Profile"
        end

  		end
  	else
      flash[:error_prompt] = 'Error: Cannot Find Profile'
  		redirect_to root_path
  	end

  end

  def account_settings

    @navigation_title = "Account Settings"

    @stripe_customer_object = current_user.stripe_customer_object

    if @stripe_customer_object 

      @user_stripe_cards = Stripe::Customer.retrieve(@stripe_customer_object.id).sources.all(:object => "card")
    
    end

    
  end
  

  def tasker_needs_image


  end

  def balance

    account = current_user.stripe_account_object

    @bank_accounts = account.external_accounts.all(:object => "bank_account", :limit => 5)


  end


  def requests

    @navigation_title = "My Requests"

    if user_signed_in?

      if current_user.is_tasker

        @service_requests = current_user.requests_assigned_to_me.sort_by(&:created_at).reverse

      else

        @service_requests = current_user.service_requests.sort_by(&:created_at).reverse

      end

    else

      redirect_to root_path

    end

  end

  def messages

    @navigation_title = "My Messages"

  end

  def live

    @navigation_title = "Live Request Feed"

    @service_requests = current_user.live_requests_for_tasker


  end

  def update_availability

    @navigation_title = "My Availability"


  end

  def add_bank_account

    account_token = Stripe::Token.create(
      :bank_account => {
        :country => "US",
        :currency => "usd",
        :account_holder_name => params[:account_holder_name],
        :account_holder_type => "individual",
        :routing_number => params[:routing_number],
        :account_number => params[:account_number],
      },
    )

    if user_signed_in?

      if current_user.stripe_account_id && current_user.stripe_secret_key

        account = Stripe::Account.retrieve(current_user.stripe_account_id)

        account.external_accounts.create(external_account: account_token.id) 

        flash[:notice] = "Account Created"
        redirect_to balance_path

      else

        flash[:notice] = "Your account is not yet verified."
        redirect_to balance_path


      end

    end

    


    


  end


end
