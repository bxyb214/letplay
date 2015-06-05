class RemoveNameFromActivity < ActiveRecord::Migration
  def change
    remove_column :activities, :name, :string
  end
end
