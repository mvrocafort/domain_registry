class AddHandleToDomain < ActiveRecord::Migration[5.2]
  def change
    add_column :domains, :handle, :string
  end
end
