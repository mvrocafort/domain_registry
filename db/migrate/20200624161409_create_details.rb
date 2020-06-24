class CreateDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :details do |t|
      t.string :first_name
      t.string :last_name
      t.string :organization
      t.string :contact_number
      t.string :address

      t.timestamps
    end
  end
end
