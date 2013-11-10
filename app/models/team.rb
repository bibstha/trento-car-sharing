class Team
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :drivers
  embeds_many :car_requests
  belongs_to :user

  field :name, type: String
  # field :country, type: String
  field :participants_count, type: Integer
  field :drive_in_mountains, type: Boolean
  field :use_snow_chains, type: Boolean
  field :other_special_requirements, type: String
  field :accept_terms_conditions, type: Boolean
end
