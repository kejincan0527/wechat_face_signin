module V1
	class Records < BaseApi
		include Grape::Kaminari

		# CarrWave_asset_host = CarrierWave::Uploader::Base.asset_host

		params do
			requires :secret_token, type: String, desc: 'access secret_token/认证密钥'
		end

		namespace :records do
			before do
				authenticate!
			end

			desc 'Generate record by face-detection-mechine/颜值机生成人脸检测记录' do
				detail 'eg: < curl -X POST -d "img_path=xxxxxx.jpg&sex=1&age=25" http://fage.29mins.com/api/v1/records/new?secret_token=03ec9545c769h89h8n097te6cc2c44948c84e0942ccd5c4b >'
				success V1::Entities::Record
				failure [ [405, '认证密钥错误'], 
									[400, '生成记录失败'] ]
			end
			params do
				requires :img_path, type: String, desc: 'ImageID from aliyun/上传至阿里云的图片ID'
				requires :sex, type: Boolean, desc: 'sex by face-detection-mechine/人脸识别时检测出的性别; 1 #=> 男； 2 #=> 女；'
				requires :age, type: Integer, desc: 'age by face-detection-mechine/人脸识别时检测出的年龄'
			end

			post 'new' do
				status 200
				record = Record.new(img_path: params[:img_path], sex: params[:sex], age: params[:age])
				if record.save
				 	present code: 200, message: 'Generate new record success', url: Wechat.get_qrcode_url(record.id)
				 	# present :data, record, with: V1::Entities::Record
			  else
			 		present code: 400, message: record.errors.full_messages.join(" && ")
			  end
			end

			# 测试使用
			desc 'Testing to make qrcode_url/测试生成二维码' do
				success V1::Entities::Record
			end
			params do
				requires :record_id, type: Integer, desc: 'id of record/人脸检测记录ID'
			end
			post 'get_qrcode_url' do
				status 200
				url = Wechat.get_qrcode_url(params[:record_id])
				{ url: url }
			end

		end
	end
end