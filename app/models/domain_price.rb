class DomainPrice < ApplicationRecord
  monetize :price_cents
  belongs_to :domain
end
