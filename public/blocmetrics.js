var blocmetrics = {};

blocmetrics.report = function(eventName){
  var event = { name: eventName };

  var request = new XMLHttpRequest();
  request.open("POST", "http://philter-108461.nitrousapp.com:3000/api/events", true);
  request.setRequestHeader('Content-Type', 'application/json');

  request.send(JSON.stringify(event));
}

// example of JavaScript to track specific events of your app

window.onload = init;

function init() {
  var topics = document.getElementById("topics");
  topics.onclick = topicviews;
};

function topicviews(){
  blocmetrics.report('topics views');
};

