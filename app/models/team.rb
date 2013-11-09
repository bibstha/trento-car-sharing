class Team
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :country, type: String
  field :number_of_participants, type: Integer
  embeds_many :drivers
  embeds_many :car_requests
end
