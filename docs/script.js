document.addEventListener("DOMContentLoaded", function() {
  document.body.onscroll = function() {
    var title = document.getElementById("tagline")
    var rect = title.getBoundingClientRect();
    var elemTop = rect.top;
    var elemBottom = rect.bottom;

    if (elemTop < 0) {
      document.getElementById("navbar").style.visibility = "visible";
      document.getElementById("navbar").style.top = "0px";
    }
    else {
      document.getElementById("navbar").style.top = "-60px";
      document.getElementById("navbar").style.visibility = "hidden";
    }
  };
});

window.addEventListener("load", function() {
  document.getElementById("title").classList.add("loaded");
});
