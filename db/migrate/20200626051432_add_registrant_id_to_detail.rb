class AddRegistrantIdToDetail < ActiveRecord::Migration[5.2]
  def up
    add_reference :details, :registrant, index: true
  end

  def down
    remove_reference :details, :registrant
  end
end
