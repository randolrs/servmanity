class StripeController < ApplicationController

  
#protect_from_forgery :except => :webhook

  if Rails.env == "production"

    Stripe.api_key = ENV['STRIPE_TEST_SECRET_KEY']

  else

    Stripe.api_key = ENV['STRIPE_TEST_SECRET_KEY']

  end

end
