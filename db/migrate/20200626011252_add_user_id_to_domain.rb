class AddUserIdToDomain < ActiveRecord::Migration[5.2]
  def up
    add_reference :domains, :user, index: true
  end

  def down
    remove_reference :domains, :user
  end
end
