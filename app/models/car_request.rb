class CarRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :team, inverse_of :car_requests
end
