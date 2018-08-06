var body = document.getElementsByTagName("BODY")[0];

document.addEventListener("DOMContentLoaded", function(event) {
                          safari.extension.dispatchMessage("Hello World!");
});

safari.self.addEventListener("message", handleMessage);

function handleMessage(event) {
    if(event.name == "ExtensionOff") {
        document.getElementsByTagName("BODY")[0].classList.remove("blackMode");
    }
    else {
        document.getElementsByTagName("BODY")[0].classList.add("blackMode");
    }
}
