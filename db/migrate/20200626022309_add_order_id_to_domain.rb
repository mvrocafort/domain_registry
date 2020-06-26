class AddOrderIdToDomain < ActiveRecord::Migration[5.2]
  def up
    add_reference :domains, :order, index: true
  end

  def down
    remove_reference :domains, :order
  end
end
