	module V1
		module Entities
			class Record < Grape::Entity
				expose :id, documentation: { type: Integer, desc: 'id of record' }, as: :record_id
			end
		end
	end
