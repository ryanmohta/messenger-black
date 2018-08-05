var body = document.getElementsByTagName("BODY")[0];
var activated = false;

document.addEventListener("DOMContentLoaded", function(event) {
                      safari.extension.dispatchMessage("Hello World!");
});

safari.self.addEventListener("message", handleMessage);

function handleMessage(event) {
    if(activated) {
        document.getElementsByTagName("BODY")[0].classList.remove("blackMode");
        activated = false;
    }
    else {
        document.getElementsByTagName("BODY")[0].classList.add("blackMode");
        activated = true;
    }
}
