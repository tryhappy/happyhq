class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

    if @user.shopify_api_key
      shop_url = "https://#{@user.shopify_api_key}:#{@user.shopify_password}@#{@user.shopify_url}"
      ShopifyAPI::Base.site = shop_url
      ShopifyAPI::Base.api_version = '2019-10'

      @products = ShopifyAPI::Product.find(:all)

      # ShopifyAPI::Base.clear_session

    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        redirect_to(:users, notice: 'User was successfully created')
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def update_product
    @user = User.find(params[:user_id])
    shop_url = "https://#{@user.shopify_api_key}:#{@user.shopify_password}@#{@user.shopify_url}"
    ShopifyAPI::Base.site = shop_url
    ShopifyAPI::Base.api_version = '2019-10'

    product = ShopifyAPI::Product.find(params[:product_id])

    product.title = 'Updated it!'

    if product.save
      redirect_to(user_path(@user), notice: 'Product was successfully updated')
    else
      redirect_to(user_path(@user), notice: 'Product update failed')
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
       params.require(:user).permit(:email, :password, :password_confirmation, :shopify_url, :shopify_api_key, :shopify_password)
    end
end
