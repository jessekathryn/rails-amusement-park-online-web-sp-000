require 'pry'
class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :edit, :update, :destroy]

  # GET /rides
  # GET /rides.json
  def index
    @rides = Ride.all
  end

  # GET /rides/1
  # GET /rides/1.json
  def show
  end

  # GET /rides/new
  def new
    @preference = Preference.first
    if @preference.allow_create_rides
    @ride = Ride.new
    else
      redirect_to rides_path
    end 
  end

  # GET /rides/1/edit
  def edit
  end

  # POST /rides
  # POST /rides.json
  def create
    @ride = Ride.new(ride_params)
    @ride.save
    @message = @ride.take_ride
    redirect_to user_path(@ride.user, message: @message)
  end

  # PATCH/PUT /rides/1
  # PATCH/PUT /rides/1.json
  def update
    respond_to do |format|
      if @ride.update(ride_params)
        format.html { redirect_to @ride, notice: 'Ride was successfully updated.' }
        format.json { render :show, status: :ok, location: @ride }
      else
        format.html { render :edit }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rides/1
  # DELETE /rides/1.json
  def destroy
    @ride.destroy
    respond_to do |format|
      format.html { redirect_to rides_url, notice: 'Ride was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ride
      @ride = Ride.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ride_params
      params.require(:ride).permit(:user_id, :attraction_id)
    end
end
