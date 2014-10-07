class CarConfig < ActiveRecord::Base
  belongs_to :car

  monetize :leasing_rate_cents, as: 'leasing_rate'

  def calculate
    response = connection.get leasing_rate_calculator_url
    response_body = JSON.parse(response.body, symbolize_names: true)

    if response.success?
      self.leasing_rate = Money.new(Integer(response_body[:leasing_rate])*100, 'EUR')
    else
      response_body.each do |msg|
        errors.add(:base, "#{msg[:error]} (#{msg[:error_code]})")
      end
    end
  end

  def validate_for_user(user)
    errors.add(:leasing_limit, 'over limit') if leasing_rate > user.limit
  end

  def connection
    @connection ||= Faraday.new(url: 'http://leasing-rate-calculator.herokuapp.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def leasing_rate_calculator_url
    "/?price=#{car.formatted_price}&period=#{leasing_period}&kilometers=#{leasing_km}"
  end

  def as_json(options={})
    { leasing_period: leasing_period, leasing_km: leasing_km, package: package, leasing_rate: leasing_rate.format }
  end
end
