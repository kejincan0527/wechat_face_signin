class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.boolean :sex
      t.string :avatar
      t.string :phone, limit: 128
      t.string :openid
      t.string :profession
      t.boolean :del, default: false

      t.timestamps null: false
    end
  end
end
