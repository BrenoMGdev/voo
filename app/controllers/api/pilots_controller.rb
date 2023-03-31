module Api
	class PilotsController < ApplicationController
		before_action :set_pilot, only: [:show, :update, :destroy]
		rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
		
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
				render json: { error: @pilot.errors }, status: :unprocessable_entity
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
				render json: { error: @pilot.errors }, status: :unprocessable_entity
			end
		end
	
		def destroy
			binding.pry
			@pilot.destroy
		end
	
		private
		def set_pilot
			@pilot = Pilot.find(params[:id])
		end
	
		def pilot_params
			params.permit(:nome, :senha, :aeronave)
		end

		def record_not_found
			render json: { error: I18n.t('errors.messages.not_found') }, status: :not_found
		end
	end
end