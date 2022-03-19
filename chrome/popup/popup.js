document.addEventListener("DOMContentLoaded", function() {

  // STARTUP

  chrome.storage.sync.get(null, function(result) {

    document.getElementById("manual").checked = result.manual;
    document.getElementById("onOff").checked = result.onOff;

    document.getElementById("scheduled").checked = result.scheduled;
    document.getElementById("startTime").value = result.startTime;
    document.getElementById("endTime").value = result.endTime;

    document.getElementById("sunsetToSunrise").checked = result.sunsetToSunrise;


    if (document.getElementById("manual").checked == true) {
      document.getElementById("onOff").disabled = false;
      document.getElementsByClassName("scheduled-div")[0].classList.add("disabled");
      document.getElementsByClassName("scheduled-div")[1].classList.add("disabled");
      document.getElementsByClassName("time-picker")[0].disabled = true;
      document.getElementsByClassName("time-picker")[1].disabled = true;
    }
    else if (document.getElementById("scheduled").checked == true) {
      document.getElementById("onOff").disabled = true;
      document.getElementsByClassName("scheduled-div")[0].classList.remove("disabled");
      document.getElementsByClassName("scheduled-div")[1].classList.remove("disabled");
      document.getElementsByClassName("time-picker")[0].disabled = false;
      document.getElementsByClassName("time-picker")[1].disabled = false;
    }
    else {
      document.getElementById("onOff").disabled = true;
      document.getElementsByClassName("scheduled-div")[0].classList.add("disabled");
      document.getElementsByClassName("scheduled-div")[1].classList.add("disabled");
      document.getElementsByClassName("time-picker")[0].disabled = true;
      document.getElementsByClassName("time-picker")[1].disabled = true;
    }


    setTimeout(function(){ document.body.classList.remove("preload"); }, 100);

  });

});

window.onload = function() {
  // ELEMENT CHANGE LISTENERS

  document.getElementById("manual").addEventListener("change", function() {
    chrome.storage.sync.set({"manual": document.getElementById("manual").checked});
    chrome.storage.sync.set({"scheduled": document.getElementById("scheduled").checked});
    chrome.storage.sync.set({"sunsetToSunrise": document.getElementById("sunsetToSunrise").checked});

    document.getElementById("onOff").disabled = false;
    document.getElementsByClassName("scheduled-div")[0].classList.add("disabled");
    document.getElementsByClassName("scheduled-div")[1].classList.add("disabled");
    document.getElementsByClassName("time-picker")[0].disabled = true;
    document.getElementsByClassName("time-picker")[1].disabled = true;

    chrome.runtime.sendMessage({name: "manualBackground"});

    chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
      chrome.tabs.sendMessage(tabs[0].id, {name: "manual", onOff: document.getElementById("onOff").checked});
    });
  });

  document.getElementById("onOff").addEventListener("change", function() {
    chrome.storage.sync.set({"onOff": document.getElementById("onOff").checked});

    chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
      chrome.tabs.sendMessage(tabs[0].id, {name: "manual", onOff: document.getElementById("onOff").checked});
    });
  });


  document.getElementById("scheduled").addEventListener("change", function() {
    chrome.storage.sync.set({"manual": document.getElementById("manual").checked});
    chrome.storage.sync.set({"scheduled": document.getElementById("scheduled").checked});
    chrome.storage.sync.set({"sunsetToSunrise": document.getElementById("sunsetToSunrise").checked});

    document.getElementById("onOff").disabled = true;
    document.getElementsByClassName("scheduled-div")[0].classList.remove("disabled");
    document.getElementsByClassName("scheduled-div")[1].classList.remove("disabled");
    document.getElementsByClassName("time-picker")[0].disabled = false;
    document.getElementsByClassName("time-picker")[1].disabled = false;

    chrome.runtime.sendMessage({name: "scheduledBackground"});

    chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
      chrome.tabs.sendMessage(tabs[0].id, {name: "scheduled", startTime: document.getElementById("startTime").value, endTime: document.getElementById("endTime").value});
    });
  });

  document.getElementById("startTime").addEventListener("change", function() {
    chrome.storage.sync.set({"startTime": document.getElementById("startTime").value});

    chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
      chrome.tabs.sendMessage(tabs[0].id, {name: "scheduled", startTime: document.getElementById("startTime").value, endTime: document.getElementById("endTime").value});
    });
  });

  document.getElementById("endTime").addEventListener("change", function() {
    chrome.storage.sync.set({"endTime": document.getElementById("endTime").value});

    chrome.tabs.query({active: true, currentWindow: true}, function(tabs) {
      chrome.tabs.sendMessage(tabs[0].id, {name: "scheduled", startTime: document.getElementById("startTime").value, endTime: document.getElementById("endTime").value});
    });
  });


  document.getElementById("sunsetToSunrise").addEventListener("change", function() {
    chrome.storage.sync.set({"manual": document.getElementById("manual").checked});
    chrome.storage.sync.set({"scheduled": document.getElementById("scheduled").checked});
    chrome.storage.sync.set({"sunsetToSunrise": document.getElementById("sunsetToSunrise").checked});

    document.getElementById("onOff").disabled = true;
    document.getElementsByClassName("scheduled-div")[0].classList.add("disabled");
    document.getElementsByClassName("scheduled-div")[1].classList.add("disabled");
    document.getElementsByClassName("time-picker")[0].disabled = true;
    document.getElementsByClassName("time-picker")[1].disabled = true;

    chrome.runtime.sendMessage({name: "sunsetToSunriseBackground"});

  });

};
