class Registrant < ApplicationRecord
    # has_many :domains
    # belongs_to :domains
    has_one :detail
    accepts_nested_attributes_for :detail

    has_one :domain
    accepts_nested_attributes_for :domain
end