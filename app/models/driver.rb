class Driver
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :team

  field :name, type: String
  field :delegation, type: String
  field :nationality, type: String
  field :dob, type: String
  field :place_of_birth, type: String
  field :street, type: String
  field :city, type: String
  field :coutry, type: String
  field :phone, type: String
  field :email, type: String
  field :phone_in_italy, type: String
  field :arrival_date, type: String
  field :departure_date, type: String

end