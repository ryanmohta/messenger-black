document.addEventListener("DOMContentLoaded", function() {
  document.title = "Messenger Black";

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

    var mql = window.matchMedia("(orientation: portrait)");

    title = document.getElementById("description")
    var rect = title.getBoundingClientRect();
    var elemTop = rect.top;
    var elemBottom = rect.bottom;

    if (mql.matches) {
      if (elemTop <= window.innerHeight * 0.6) {
        document.getElementById("description").classList.add("visible");
        setTimeout(function() {
          document.getElementById("download-buttons").classList.add("visible");
        }, 350);
      }
    }
    else {
      if (elemTop <= window.innerHeight * 0.75) {
        document.getElementById("description").classList.add("visible");
        setTimeout(function() {
          document.getElementById("download-buttons").classList.add("visible");
          document.getElementById("mobile-download-message").classList.add("visible");
        }, 350);
      }
    }

    title = document.getElementById("customization")
    var rect = title.getBoundingClientRect();
    var elemTop = rect.top;
    var elemBottom = rect.bottom;

    if (mql.matches) {
      if (elemTop <= window.innerHeight * 0.75) {
        document.getElementById("customization").classList.add("visible");
      }
    }
    else {
      if (elemTop <= window.innerHeight * 0.75) {
        document.getElementById("customization").classList.add("visible");
      }
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
    }, 250);
  }, 800);

});
