class Api::V1::MotorcyclesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_motorcycle, only: %i[show update destroy]

  def index
    render json: Motorcycle.all
  end
  def show
    render json: @motorcycle
  end

  def create
    motorcycle = Motorcycle.new(motorcycle_params)
    if motorcycle.save
      render json: {
        status: 201,
        message: 'Vehicle Created Successfully'
      }, status: :created
    else
      render json: motorcycle.errors, status: :unprocessable_entity
    end
  end

  def update
    if @motorcycle.update(motorcycle_params)
      render json: {
        status: 200,
        message: 'Vehicle Updated Successfully'
      }, status: :ok
    else
      render json: @motorcycle.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @motorcycle.destroy
      render json: {
        status: 200,
        message: 'Vehicle Deleted Successfully'
      }, status: :ok
    else
      render json: @motorcycle.errors, status: :unprocessable_entity
    end
  end
  private

  def set_motorcycle
    @motorcycle = Motorcycle.find(params[:id])
  end

  def motorcycle_params
    params.require(:motorcycle).permit(:name, :category, :price, :description, :image)
  end
end
