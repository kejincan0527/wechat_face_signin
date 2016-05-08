class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.boolean :sex
      t.string :avatar
      t.string :phone
      t.string :openid
      t.string :profession
      t.boolean :del

      t.timestamps null: false
    end
  end
end
