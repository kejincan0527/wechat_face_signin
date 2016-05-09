class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :user, index: true, foreign_key: true
      t.string :img_path
      t.boolean :sex
      t.integer :age
      t.boolean :del, default: false

      t.timestamps null: false
    end
  end
end
