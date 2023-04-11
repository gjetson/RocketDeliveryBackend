class CourierStatusesController < ApplicationController
  before_action :set_courier_status, only: %i[ show edit update destroy ]

  # GET /courier_statuses or /courier_statuses.json
  def index
    @courier_statuses = CourierStatus.all
  end

  # GET /courier_statuses/1 or /courier_statuses/1.json
  def show
  end

  # GET /courier_statuses/new
  def new
    @courier_status = CourierStatus.new
  end

  # GET /courier_statuses/1/edit
  def edit
  end

  # POST /courier_statuses or /courier_statuses.json
  def create
    @courier_status = CourierStatus.new(courier_status_params)

    respond_to do |format|
      if @courier_status.save
        format.html { redirect_to courier_status_url(@courier_status), notice: "Courier status was successfully created." }
        format.json { render :show, status: :created, location: @courier_status }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @courier_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courier_statuses/1 or /courier_statuses/1.json
  def update
    respond_to do |format|
      if @courier_status.update(courier_status_params)
        format.html { redirect_to courier_status_url(@courier_status), notice: "Courier status was successfully updated." }
        format.json { render :show, status: :ok, location: @courier_status }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @courier_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courier_statuses/1 or /courier_statuses/1.json
  def destroy
    @courier_status.destroy

    respond_to do |format|
      format.html { redirect_to courier_statuses_url, notice: "Courier status was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_courier_status
      @courier_status = CourierStatus.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def courier_status_params
      params.require(:courier_status).permit(:name)
    end
end
