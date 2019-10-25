class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_user_tasks, only: [:index]

  # GET /tasks
  # GET /tasks.json
  def index

  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.build()
    if current_user.shopify_api_key
      shop_url = "https://#{current_user.shopify_api_key}:#{current_user.shopify_password}@#{current_user.shopify_url}"
      ShopifyAPI::Base.site = shop_url
      ShopifyAPI::Base.api_version = '2019-10'

      @products = ShopifyAPI::Product.find(:all)

      # ShopifyAPI::Base.clear_session

    end
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      ShopifyTaskRunnerJob.set(wait_until: @task.execute_on).perform_later(@task)
      redirect_to @task, notice: 'Task was successfully created.'
    else
      format.html { render :new }
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_user_tasks
      @tasks = current_user.tasks
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :user_id, :status, :object_type, :object_id, :instructions, :instruction_value, :execute_on)
    end
end
