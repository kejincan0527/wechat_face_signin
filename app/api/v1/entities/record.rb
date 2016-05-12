	module V1
		module Entities
			class Record < Grape::Entity
				expose :url, documentation: { type: String, desc: 'url of record' }
			end
		end
	end
