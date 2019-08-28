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

      // // Only completely visible elements return true:
      // var isVisible = (elemTop >= 0) && (elemBottom <= window.innerHeight);
      // // Partially visible elements return true:
      // //isVisible = elemTop < window.innerHeight && elemBottom >= 0;
      // return isVisible;
  };

});
