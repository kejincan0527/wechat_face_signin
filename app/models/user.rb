class User < ActiveRecord::Base
	has_many :scan_records
end
