class UserServiceCategoriesController < ApplicationController
  before_action :set_user_service_category, only: [:show, :edit, :update, :destroy]

  # GET /user_service_categories
  # GET /user_service_categories.json
  def index
    @user_service_categories = UserServiceCategory.all
  end

  # GET /user_service_categories/1
  # GET /user_service_categories/1.json
  def show
  end

  # GET /user_service_categories/new
  def new
    @user_service_category = UserServiceCategory.new

    if params[:category_url]

      @service_category = ServiceCategory.where(:url_name => params[:category_url]).last
      @navigation_title = "Add Services"
    end


  end

  # GET /user_service_categories/1/edit
  def edit
  end

  # POST /user_service_categories
  # POST /user_service_categories.json
  def create
    
    if user_signed_in?
      if current_user.is_tasker

      @user_service_category = UserServiceCategory.new(user_service_category_params)

      respond_to do |format|
        if @user_service_category.save

          @user_service_category.update(:user_id => current_user.id)
          
          format.html { redirect_to root_path, notice: 'User service category was successfully created.' }
          format.json { render :show, status: :created, location: @user_service_category }
        else
          format.html { render :new }
          format.json { render json: @user_service_category.errors, status: :unprocessable_entity }
        end
      end

      else
        redirect_to root_path
      end
    
    else

      redirect_to root_path

    end

  end

  # PATCH/PUT /user_service_categories/1
  # PATCH/PUT /user_service_categories/1.json
  def update
    respond_to do |format|
      if @user_service_category.update(user_service_category_params)
        format.html { redirect_to @user_service_category, notice: 'User service category was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_service_category }
      else
        format.html { render :edit }
        format.json { render json: @user_service_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_service_categories/1
  # DELETE /user_service_categories/1.json
  def destroy
    @user_service_category.destroy
    respond_to do |format|
      format.html { redirect_to user_service_categories_url, notice: 'User service category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_service_category
      @user_service_category = UserServiceCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_service_category_params
      params.require(:user_service_category).permit(:user_id, :service_category_id, :description, :hourly_rate)
    end
end
