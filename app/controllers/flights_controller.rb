class FlightsController < ApplicationController

  def index
    @airports = Airport.all
    @departure_dates = Flight.pluck(:departure_time)
                             .map(&:to_date)
                             .uniq
                             .sort

    if flight_params.values.all?(&:blank?)
      @flights = []
    else
      @flights =
        Flight.where(departure_airport_id: flight_params[:departure_airport_id])
              .where(arrival_airport_id: flight_params[:arrival_airport_id])
              .where("DATE(departure_time) = ?", flight_params[:departure_date])
      puts "FLIGHTS #{@flights.size}"
      render :index
    end


  end

  private

  def flight_params
    params.permit(
      :departure_airport_id,
      :arrival_airport_id,
      :departure_date,
      :n_passengers,
      :commit)
          .tap { |p| p.delete(:commit) }
  end

end
