import axios from 'axios';
var timerVariable;

// Initialization
chrome.runtime.onInstalled.addListener(function(details){
  if(details.reason == "install") {
    chrome.storage.sync.set({"manual": true});
    chrome.storage.sync.set({"onOff": true});

    chrome.storage.sync.set({"scheduled": false});
    chrome.storage.sync.set({"startTime": "19:30"});
    chrome.storage.sync.set({"endTime": "07:00"});

    chrome.storage.sync.set({"sunsetToSunrise": false});
  }
});

chrome.extension.onMessage.addListener(
  function(request, sender, sendResponse) {
    if (request.message === "activate_icon") {
      chrome.pageAction.show(sender.tab.id);

      chrome.tabs.query({active: true, lastFocusedWindow: true}, tabs => {
        let url = tabs[0].url;

        // Check if extension is run on facebook.com
        if (url.includes('facebook.com')) {
          chrome.tabs.insertCSS(tabs[0].id, {
            file: "/dist/styles/base.css"
          });
        } // Check if extension is run on messenger.com
        else if (url.includes('messenger.com')) {
          chrome.tabs.insertCSS(tabs[0].id, {
            file: "/dist/styles/base.css"
          });
          chrome.tabs.insertCSS(tabs[0].id, {
            file: "/dist/styles/messengersite.css"
          });
        }
      });
    }
  }
);

chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    if (request.name == "manualBackground") {
      clearInterval(timerVariable);
    }
    else if (request.name == "scheduledBackground") {
      clearInterval(timerVariable);
    }
    else if (request.name == "sunsetToSunriseBackground") {
      const url=`http://api.ipstack.com/check?access_key=${process.env.IPSTACK_APIKEY}`;
      axios.get(url)
      .then((data) => {
        chrome.tabs.query({active: true, lastFocusedWindow: true}, function(tabs) {
          chrome.tabs.sendMessage(tabs[0].id, {name: "sunsetToSunrise", latitude: data.data.latitude, longitude: data.data.longitude});
        });
        clearInterval(timerVariable);
        timerVariable = setInterval(getLocation, 86400);
      })
      .catch(err=>console.log(err));
    }
  }
);
