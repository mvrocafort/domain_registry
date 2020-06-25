class AddHandleToRegistrant < ActiveRecord::Migration[5.2]
  def change
    add_column :registrants, :handle, :string
  end
end
