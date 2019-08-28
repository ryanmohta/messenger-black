document.addEventListener("DOMContentLoaded", function() {
  document.body.onscroll = function() {
    var title = document.getElementById("title")
    var rect = title.getBoundingClientRect();
    var elemTop = rect.top;
    var elemBottom = rect.bottom;

    if (elemTop < 0) {
      document.getElementById("navbar").visibility = visible;
    }
    else {
      document.getElementById("navbar").visibility = hidden;
    }

      // // Only completely visible elements return true:
      // var isVisible = (elemTop >= 0) && (elemBottom <= window.innerHeight);
      // // Partially visible elements return true:
      // //isVisible = elemTop < window.innerHeight && elemBottom >= 0;
      // return isVisible;
  };

});
