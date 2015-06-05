class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :baby_name
      t.integer :baby_age
      t.string :image_url
      t.string :password
      t.string :email

      t.timestamps null: false
    end
  end
end
