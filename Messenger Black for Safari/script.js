var body = document.getElementsByTagName("BODY")[0];
var timerVariable;

//document.addEventListener("DOMContentLoaded", myTimer);

document.addEventListener("DOMContentLoaded", initialized);

function initialized() {
    safari.extension.dispatchMessage("Initialized");
}


safari.self.addEventListener("message", handleMessage);

function handleMessage(event) {
    if(event.name === "Manual Changed") {
        manualChanged(event);
    }
    else if(event.name === "Scheduled Changed") {
        scheduledChanged(event);
    }
}

function manualChanged(event) {
    clearInterval(timerVariable);
    if(event.message["State"] === "On") {
        document.getElementsByTagName("BODY")[0].classList.add("blackMode");
    }
    else {
        document.getElementsByTagName("BODY")[0].classList.remove("blackMode");
    }
}

function scheduledChanged(event) {
    var startTimeDate = new Date(event.message["Start Time"]);
    var endTimeDate = new Date(event.message["End Time"]);
    
    var startTimeHour = startTimeDate.getHours();
    var startTimeMinute = startTimeDate.getMinutes();
    
    var endTimeHour = endTimeDate.getHours();
    var endTimeMinute = endTimeDate.getMinutes();
    
    timerVariable = setInterval(scheduledTimer, 1000);
}

function scheduledTimer() {
    var currentDate = new Date();
    var currentHour = date.getHours();
    var currentMinute = date.getMinutes();
    
    if(currentHour < endTimeHour || (currentHour <= endTimeHour && currentMinute < endTimeMinute) || (currentHour >= startTimeHour && currentMinute >= endTimeMinute) || currentHour > startTimeHour) {
        document.getElementsByTagName("BODY")[0].classList.add("blackMode");
    }
    else {
        document.getElementsByTagName("BODY")[0].classList.remove("blackMode");
    }
    
    /*if(hour < 7 || /*(hour >= 17 && minute >= 30) || hour >= 18) {
        document.getElementsByTagName("BODY")[0].classList.add("blackMode");
    }
    else {
        document.getElementsByTagName("BODY")[0].classList.remove("blackMode");
    }*/
}



/*safari.self.addEventListener("Sunset to Sunrise Changed", sunsetToSunriseChanged);*/




