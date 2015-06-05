class AddFieldsToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :title, :string
    add_column :activities, :sponsor_id, :integer
    add_column :activities, :acceptable, :boolean
    add_column :activities, :location, :string
    add_column :activities, :end_time, :datetime
  end
end
