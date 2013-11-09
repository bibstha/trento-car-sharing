class Driver
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  embedded_in :team, inverse_of :drivers
end
