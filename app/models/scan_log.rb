class ScanLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :record
end
