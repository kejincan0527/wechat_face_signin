class AddNameToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string, after: :id
  	add_column :users, :subscribed_at, :datetime, after: :profession
  	change_column :users, :sex, :integer, limit: 2
  end
end
