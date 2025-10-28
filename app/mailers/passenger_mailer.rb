class PassengerMailer < ApplicationMailer
  default from: "test@example.com"
  layout "mailer"

  def booking_confirmation
    @passenger = params[:passenger]
    @booking = params[:booking]
    mail(to: @passenger.email, subject: "Booking confirmed")
  end
end
