class AddDistanceToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :distance, :decimal
  end
end
