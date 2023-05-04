class PassengersController < ApplicationController
    before_action :set_passenger, only: [:show, :update, :destroy]

    def index
      passengers = Passenger.all

      render json: passengers, status: :ok
    end
  
	def show
		render json: @passenger, status: :ok
	end
  
    def new
      @passenger = Passenger.new
    end
  
    def create
      @passenger = Passenger.new(passenger_params)
  
      if @passenger.save
        redirect_to @passenger
      else
        render 'new'
      end
    end  
  
    def update
		@passenger.update(
			cpf: params["cpf"],
			passport: params["passport"],
            country: params["country"],
            name: params["name"],
            surname: params["surname"],
            password: params["password"],
            miles: params["miles"],
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
      def passenger_params
        params.require(:passenger).permit(:cpf, :passport, :country, :name, :surname, :password, :miles)
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