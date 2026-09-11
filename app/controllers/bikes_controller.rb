class BikesController < ApplicationController
  before_action :authenticate_request!, except: [ :index, :show ]
  before_action :set_bike, only: [ :show, :update ]

  def index
    render json: Bike.all
  end

  def show
    render json: @bike
  end

  def create
    bike = Bike.new(bike_params)
    if bike.save
      render json: bike, status: :created
    else
      render json: { errors: bike.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @bike.update(bike_params)
      render json: @bike
    else
      render json: { errors: @bike.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_bike
    @bike = Bike.find(params[:id])
  end

  def bike_params
    params.permit(:name, :latitude, :longitude, :reserved, :locked, :lock_code)
  end
end
