class DeleteContactHandleFromRegistrant < ActiveRecord::Migration[5.2]
  def change
    remove_column :registrants, :contact_handle
  end
end
