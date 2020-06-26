class CreateDomainPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :domain_prices do |t|
      t.string :price_cents
      t.string :currency
      t.belongs_to :domain, foreign_key: true

      t.timestamps
    end
  end
end
