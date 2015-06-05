class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :global_key, :string
    add_column :users, :path, :string
    add_column :users, :slogan, :string
    add_column :users, :baby_birthday, :date
    add_column :users, :baby_hobby, :string
    add_column :users, :baby_school, :string
    add_column :users, :sex, :integer
    add_column :users, :baby_sex, :integer
    add_column :users, :introduction, :string
  end
end
