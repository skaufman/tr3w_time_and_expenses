class Person < ActiveRecord::Base
  has_many :contact_cards, :as => :contact
end
