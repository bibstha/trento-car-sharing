class Team
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :drivers
  embeds_many :car_requests
  belongs_to :user

  field :name, type: String
  # field :country, type: String
  field :participants_count, type: String
  field :number_of_cars, type: String
  field :drive_in_mountains, type: Boolean
  field :use_snow_chains, type: Boolean
  field :other_special_requirements, type: String
  field :accept_terms_conditions, type: Boolean

  field :flags, type: Hash, default: {}

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << %w(Name Participants\ Count Number\ of\ cars Drive\ in\ mountains
        Use\ snow\ chains Other\ Requirements Number\ of\ drivers Link)
      order_by(:name => 1).each do |team|
        csv << [team.name, team.participants_count, team.number_of_cars, team.drive_in_mountains,
          team.use_snow_chains, team.other_special_requirements, team.drivers.count, "http://universiad2013.88yaks.com/admin/teams/#{team.id}"]
      end
    end
  end

  def self.drivers_csv(options = {})
    CSV.generate(options) do |csv|
      csv << %w(Team Type DriverName Nationality DoB PlaceOfBirth Street City Country Phone Email
        PhoneInItaly ArrivalDate ArrivalTime DepartureDate DepartureTime Document)
      order_by(:name => 1).each do |team|
        line = []
        team.drivers.order_by(:name => 1).each do |driver|
          line = [team.name]
          line = line + [driver.type, driver.name, driver.nationality, driver.dob, driver.place_of_birth,
            driver.street, driver.city, driver.country, driver.phone, driver.email, driver.phone_in_italy,
            driver.arrival_date, driver.arrival_time, driver.departure_date, driver.departure_time]
          line = line + driver.documents.map do |doc|
            "http://universiad2013.88yaks.com/system/uploads/#{doc}"
          end
          csv << line
        end
      end
    end
  end

  def zip_file
    unless self.name
      return nil
    end

    require 'zip'

    zipfile_name = Rails.root.join('public', 'system', 'uploads', self.name.gsub(" ", '') + ".zip")
    if File.exist?zipfile_name
      File.delete zipfile_name
    end
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      self.drivers.order_by(:name => 1).each do |driver|
        driver.documents.each do |doc|
          uploaded_file = Rails.root.join('public', 'system', 'uploads', doc)
          zipfile.add("#{self.name}/#{driver.name}/#{doc}", uploaded_file) if File.exist? uploaded_file
        end
      end
    end

    zipfile_name
  end
end
