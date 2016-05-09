class User < ActiveRecord::Base
	has_many :records
	has_many :scan_logs
end
