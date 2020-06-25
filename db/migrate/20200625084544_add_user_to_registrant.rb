class AddUserToRegistrant < ActiveRecord::Migration[5.2]
  def up
    add_reference :registrants, :user, index: true
  end

  def down
    remove_reference :registrants, :user
  end
end
