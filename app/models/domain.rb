class Domain < ApplicationRecord
	belongs_to :user
	belongs_to :order
	belongs_to :registrant
	
	has_one :domain_price
	accepts_nested_attributes_for :domain_price
	

	def self.search(search)
		#search is the domain name
		if search #if there is an input
			domain = Domain.find_by(domain_name: search)
			if domain
				self.where(id: domain)
			end
		end
	end
end