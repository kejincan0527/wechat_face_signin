namespace :api do
	desc "Show API Routes"
	task routes: [:environment] do
	  Base.routes.each do |api|
	    prefix = '/api'
	    method = api.route_method.ljust(10)
	    path = api.route_path
	    puts "     #{method} #{prefix}#{path}"
	  end
	end
end