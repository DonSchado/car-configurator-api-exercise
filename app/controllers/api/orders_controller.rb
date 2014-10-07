module API
  class OrdersController < ApplicationController
    def create
      if (@car_config = CarConfig.find(params[:car_config_id]))
        @order = @car_config.orders.create(order_params)
        render json: @order, status: :created
      else
        render json: { error: 'no such configuration' }, status: 404
      end
    end

    def show
      @order = Order.find(params[:id])
      render json: @order, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'no such order for you my friend!'}, status: 404
    end

    private

    def order_params
      params.require(:order).permit(:address, :car_house)
    end
  end
end
