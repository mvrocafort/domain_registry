class Domain < ApplicationRecord
	belongs_to :user
	def self.search(search)
		#search is the domain name
		if search #if may input
			domain = Domain.find_by(domain_name: search)
			if domain
				self.where(id: domain)
			#else
				#Domain.all
			end
		#else
			#Domain.all
		end
	end
end
