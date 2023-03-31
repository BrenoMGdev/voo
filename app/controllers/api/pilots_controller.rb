module Api
	class PilotsController < ApplicationController
		before_action :set_pilot, only: [:show, :update, :destroy]
		
		def index
			@pilots = Pilot.all.map{|p| p.to_json }
	
			render json: @pilots
		end
	
		def show
			render json: @pilot.to_json
		end
	
		def create
			@pilot = Pilot.new(
				name: params[:nome],
				password: params[:senha],
				aircraft: params[:aeronave]
			)
	
			if @pilot.save
				render json: @pilot.to_json, status: :created
			else
				render json: @pilot.errors, status: :unprocessable_entity
			end
		end
	
		def update
			if @pilot.update(
				name: params[:nome],
				password: params[:senha],
				aircraft: params[:aeronave]
			)
				render json: @pilot.to_json
			else
				render json: @pilot.errors, status: :unprocessable_entity
			end
		end
	
		def destroy
			@pilot.destroy
		end
	
		private
		def set_pilot
			@pilot = Pilot.find(params[:id])
		end
	
		def pilot_params
			params.permit(:nome, :senha, :aeronave)
		end
	end
end