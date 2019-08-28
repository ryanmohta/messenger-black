document.addEventListener("DOMContentLoaded", function() {
  document.body.onscroll = function() {
    var title = document.getElementById("tagline")
    var rect = title.getBoundingClientRect();
    var elemTop = rect.top;
    var elemBottom = rect.bottom;

    if (elemTop < 0) {
      document.getElementById("navbar").classList.add("visible");
    }
    else {
      document.getElementById("navbar").classList.remove("visible");
    }

    title = document.getElementById("description")
    var rect = title.getBoundingClientRect();
    var elemTop = rect.top;
    var elemBottom = rect.bottom;

    if (elemTop <= window.innerHeight - 200) {
      document.getElementById("description").classList.add("visible");
      setTimeout(function() {
        document.getElementById("download-buttons").classList.add("visible");
      }, 350);
    }
  };
});

addEventListener("load", function() {
  setTimeout(function() {
    document.getElementById("title").classList.add("loaded");
    setTimeout(function() {
      document.getElementById("tagline").classList.add("loaded");
      setTimeout(function() {
        document.getElementById("promo").classList.add("loaded");
      }, 1250);
    }, 350);
  }, 500);

});
