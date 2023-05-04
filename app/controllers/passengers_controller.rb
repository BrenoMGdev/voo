class PassengersController < ApplicationController
  before_action :set_passenger, only: [:show, :update, :destroy]

  def index
    where = ["1=1"]

		where << "cpf = '#{ params["cpf"] }'" if params["cpf"].present?
		where << "name = '#{ params["name"] }'" if params["name"].present?
    where << "surname = '#{ params["surname"] }'" if params["surname"].present?

		passengers = Passenger
			.where(where.join(" AND "))
			.map{|p| p.dto_json }

    render json: passengers, status: :ok
  end
  
	def show
		render json: @passenger.dto_json, status: :ok
	end

  def create
    @passenger = Passenger.new(
			cpf: params["cpf"],
			passport: params["passport"],
      country: params["country"],
      name: params["name"],
      surname: params["surname"],
      password: params["password"],
      miles: params["miles"]
		)

    if not @passenger.valid?
			raise
		end

		@passenger.save
		
		render json: @passenger.dto_json, status: :ok
	rescue
		render status: :bad_request
	end

  def update
		@passenger.update(
			cpf: params["cpf"],
			passport: params["passport"],
      country: params["country"],
      name: params["name"],
      surname: params["surname"],
      password: params["password"],
      miles: params["miles"]
		)

		render json: @passenger, status: :ok
	rescue
		render status: :bad_request
	end
  
	# DELETE
	def destroy
		@passenger.destroy

		render json: @passenger, status: :ok
	end
  
  private
  def set_passenger
    passenger_id = params[:id]

    if passenger_id.present?
      @passenger = Passenger.find(passenger_id)
    else
      render status: :bad_request
    end
	end
end