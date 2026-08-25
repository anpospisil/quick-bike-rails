class ReservationsController < ApplicationController
  before_action :authenticate_request!

  # POST /reservations
  # Creates a new reservation, generates a lock code, marks bike reserved
  def create
    bike = Bike.find_by(id: params[:bike_id])
    return render json: { message: "bike is not found!" }, status: :not_found unless bike

    reservation = Reservation.create!(
      bike_id: bike.id,
      user_id: @current_user.id,
      start_time: params[:start_time]
    )

    lock_code = rand(100_000..999_999)
    bike.update!(reserved: params[:reserved], lock_code: lock_code)

    # TODO: send confirmation email (ActionMailer) — original Node version emailed lock code here

    render json: { message: "Reservation created", reservation: reservation, bike: bike }, status: :ok
  end

  # PATCH /reservations/end
  # Ends the user's most recent reservation, calculates cost, unlocks bike
  def end_reservation
    reservation = Reservation.where(user_id: @current_user.id).order(created_at: :desc).first
    return render json: { message: "no active reservation" }, status: :not_found unless reservation

    end_time = Time.current
    total_hours = ((end_time - reservation.start_time).abs / 3600).floor
    cost = total_hours <= 12 ? 2 : 3

    reservation.update!(end_time: end_time, cost: cost)

    bike = Bike.find(reservation.bike_id)
    bike.update!(reserved: params[:reserved])

    # TODO: send reservation-ended email (ActionMailer)

    render json: { reservation: reservation, bike: bike }, status: :ok
  end

  # GET /reservations
  # Returns the user's most recent reservation
  def show_current
    reservation = Reservation.where(user_id: @current_user.id).order(created_at: :desc).first
    render json: { reservation: reservation }, status: :ok
  end
end