class CreateParticipates < ActiveRecord::Migration
  def change
    create_table :participates do |t|
      t.belongs_to :user, index: true
      t.belongs_to :activity, index: true
      t.timestamps null: false
    end
  end
end