class Driver
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :team

  field :type, type: String
  field :name, type: String
  field :delegation, type: String
  field :nationality, type: String
  field :dob, type: String
  field :place_of_birth, type: String
  field :street, type: String
  field :city, type: String
  field :country, type: String
  field :phone, type: String
  field :email, type: String
  field :phone_in_italy, type: String
  field :arrival_date, type: String
  field :departure_date, type: String

  # Stores references to uploaded documents
  field :documents, type: Array, default: []

end