== README
Link to production version: https://viral-blocmetrics.herokuapp.com/

This application provides an analytics service which:

1. enables users to track events on their website

2. captures those events to a database via a server-side API

3. displays the event data

* Using Rails 4.2.1

* Deployment on Heroku

* See __application.example.yml__ for environment variables

Use the following JavaScript in the Rails application whose events you want to track
placing it in the app/assets/javascripts/application.js file:

    var blocmetrics = {};

    blocmetrics.report = function(eventName){
      var event = { name: eventName };

      var request = new XMLHttpRequest();
      // the http path is an example, use production path
      request.open("POST", "http://localhost:3000/api/events", true);
      request.setRequestHeader('Content-Type', 'application/json');

      request.send(JSON.stringify(event));
    }

This is an example of JavaScript to track specific events of your app; 
include such script in same file as above:

    window.onload = init;

    function init() {
      var topics = document.getElementById("topics");
      topics.onclick = topicviews;
    };

    function topicviews(){
      blocmetrics.report('topics views');
    };

Additionally, install the rack-cors gem in your Blocmetrics.

    gem 'rack-cors', :require => 'rack/cors'

Include at least one of the following configurations for Blocmetrics app event tracking.

In your _config.ru_ include:

    use Rack::Cors do
      allow do
        # regular expressions can be used here
        origins '*'

        # headers to expose
        resource '/api/events', :headers => :any, :methods => [:get, :post, :options]
      end
      allow do
        origins '*'
        resource '/api/events', :headers => :any, :methods => [:get, :post, :options]
      end
    end

OR, in your config/application.rb file include within:

    class Application < Rails::Application

the following configuration for Blocmetrics:

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end



* Testing via RSpec

**Services (job queues, cache servers, search engines, etc.)**

**Deployment instructions**

* ...


