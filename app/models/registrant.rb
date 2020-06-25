class Registrant < ApplicationRecord
    has_many :domains
    accepts_nested_attributes_for :domains
end