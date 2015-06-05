class RemoveSponsorIdFromUser < ActiveRecord::Migration
  def change
    remove_column :activities, :sponsor_id, :integer
  end
end
