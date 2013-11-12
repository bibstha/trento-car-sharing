class ActionLog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_token, type: String
  field :action, type: String
  field :target, type: String
  field :referrer, type: String
  field :version, type: String
  field :ip, type: String
  field :locale, type: String
end
