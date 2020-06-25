class AddRegistrantToDomain < ActiveRecord::Migration[5.2]
  def up
    add_reference :domains, :registrant, index: true
  end

  def down
    remove_reference :domains, :registrant
  end
end
