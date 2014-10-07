module API
  class CarsController < API::ApplicationController
    def index
      render json: Car.all
    end
  end
end
