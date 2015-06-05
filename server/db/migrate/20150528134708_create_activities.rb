class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.datetime :start_time
      t.datetime :created_time
      t.datetime :updated_time
      t.integer :max_number
      t.string :image_url
      t.decimal :location_longitude
      t.decimal :location_latitude

      t.timestamps null: false
    end
  end
end
