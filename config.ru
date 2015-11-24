# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
use Rack::Cors do
  allow do
    origins '*'
            # regular expressions can be used here

    resource '/api/events', :headers => :any, :methods => [:get, :post, :options]
        # headers to expose
  end

  allow do
    origins '*'
    resource '/api/events', :headers => :any, :methods => [:get, :post, :options]
  end
end
