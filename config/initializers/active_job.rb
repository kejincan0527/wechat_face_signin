# config/initializers/active_job.rb 
if Rails.env.test?
  ActiveJob::Base.queue_adapter = :inline
else
  ActiveJob::Base.queue_adapter = :sidekiq
end