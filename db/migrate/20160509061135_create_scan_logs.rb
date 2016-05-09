class CreateScanLogs < ActiveRecord::Migration
  def change
    create_table :scan_logs do |t|
      t.references :user, index: true, foreign_key: true
      t.references :record, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
