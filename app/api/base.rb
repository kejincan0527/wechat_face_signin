require 'grape-swagger'
class Base < Grape::API
  	
  helpers do
    API_SECRET = "03ec9545c769h89h8n097te6cc2c44948c84e0942ccd5c4b"

    def authenticate!
      error!({ code: 405, message: 'Unauthorized' }, 405) if params[:secret_token] != API_SECRET
    end
  end

  version 'v1' , using: :path
  format :json

  mount V1::Records
  
  # if !Rails.env.production?
    add_swagger_documentation(api_version: "v1", 
                              base_path: "api", 
                              hide_format: true, 
                              hide_documentation_path: true)
  # end
end