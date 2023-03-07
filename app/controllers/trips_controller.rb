class TripsController < ApplicationController
  def index
    @trips = Trip.all
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def edit
  end

  def show
    @trip = Trip.find(params[:id])
    @booking = Booking.new
  end

  def my_trips
    # @user = current_user
    @trips = Trip.where(user_id: current_user.id)
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to my_trips_path(current_user), status: :see_other
  end
  
  private
  
  def trip_params
    params.required(:trip).permit(:name, :activity_type, :destination, :departure_point, :description, :features, :price, :seats)
  end

end
