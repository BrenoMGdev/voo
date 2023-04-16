class ApplicationController < ActionController::API
	before_action :snake_case_params
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	private

	def snake_case_params
		request.parameters.deep_transform_keys!(&:underscore)
	end

	def record_not_found
		render status: :not_found
	end
end
