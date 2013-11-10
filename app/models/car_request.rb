class CarRequest
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :team
end
