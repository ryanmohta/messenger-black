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
    
    if(event.message["State"] === "On") {
        document.getElementsByTagName("BODY")[0].classList.add("blackMode");
    }
    else {
        document.getElementsByTagName("BODY")[0].classList.remove("blackMode");
    }
    
    clearInterval(timerVariable);
}

function scheduledChanged(event) {
    var startTimeDate = new Date(event.message["Start Time"]);
    var endTimeDate = new Date(event.message["End Time"]);
    
    var startTimeHour = startTimeDate.getHours();
    var startTimeMinute = startTimeDate.getMinutes();
    
    var endTimeHour = endTimeDate.getHours();
    var endTimeMinute = endTimeDate.getMinutes();
    
    scheduledTimer(startTimeHour, startTimeMinute, endTimeHour, endTimeMinute);
    
    clearInterval(timerVariable);
    timerVariable = setInterval(scheduledTimer, 1000, startTimeHour, startTimeMinute, endTimeHour, endTimeMinute);
}

function scheduledTimer(startTimeHour, startTimeMinute, endTimeHour, endTimeMinute) {
    var currentDate = new Date();
    var currentHour = currentDate.getHours();
    var currentMinute = currentDate.getMinutes();
    
    if(currentHour < endTimeHour || (currentHour <= endTimeHour && currentMinute < endTimeMinute) || (currentHour >= startTimeHour && currentMinute >= startTimeMinute) || currentHour > startTimeHour) {
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




