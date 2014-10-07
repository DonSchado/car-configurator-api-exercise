module API
  class CarConfigsController < API::ApplicationController

    def create
      @car_config = CarConfig.new(car_config_params)

      @car_config.calculate
      if @car_config.valid_for_user?(@user)
        @car_config.save
        render json: @car_config, status: :created
      else
        render json: @car_config.errors, status: :unprocessable_entity
      end
    end

    private

    def car_config_params
      params.require(:car_config).permit(:car_id, :leasing_period, :leasing_km, :package)
    end
  end
end
