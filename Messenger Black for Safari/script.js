var body = document.getElementsByTagName("BODY")[0];

document.addEventListener("DOMContentLoaded", myTimer);

var timerVariable = setInterval(myTimer, 1000);

function myTimer() {
    var date = new Date();
    var hours = date.getHours();
    if(hours < 7 || hours > 16) {
        document.getElementsByTagName("BODY")[0].classList.add("blackMode");
    }
    else {
        document.getElementsByTagName("BODY")[0].classList.remove("blackMode");
    }
}

//safari.self.addEventListener("message", handleMessage);

/*function handleMessage(event) {
    if(event.name == "ExtensionOff") {
        document.getElementsByTagName("BODY")[0].classList.remove("blackMode");
    }
    else {
        document.getElementsByTagName("BODY")[0].classList.add("blackMode");
    }
}*/
