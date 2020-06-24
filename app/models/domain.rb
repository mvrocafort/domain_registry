class Domain < ApplicationRecord
    def self.search(search)
		if search
			domain = Domain.find_by(domain_name: search)
			if domain
				self.where(id: domain)
			else
				Domain.all
			end
		else
			Domain.all
		end
	end
end
