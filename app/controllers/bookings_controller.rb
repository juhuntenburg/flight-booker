class BookingsController < ApplicationController
  def new
    @flight = Flight.find(booking_params[:flight_id])
  end

  private

  def booking_params
    params.permit(:flight_id,
                  :n_passengers,
                  :commit).tap { |p| p.delete(:commit) }
  end
end
