class CreateRegistrants < ActiveRecord::Migration[5.2]
  def change
    create_table :registrants do |t|
      t.string :contact_handle

      t.timestamps
    end
  end
end
