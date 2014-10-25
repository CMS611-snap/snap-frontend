var SnapController = (function() {

  var local = {};

  function SnapController() {}

  SnapController.prototype.init = function() {
    local.eventListeners();
  }

  local.eventListeners = function() {
    $("#snapForm").on("submit", function(e) {

      // Prevents page reload
      e.preventDefault();
      var data = $(this).serializeArray();

      $.ajax({
        type: "POST", 
        url: "/test", 
        data: data
      }).done(function(res) {
        console.log("res: ", JSON.stringify(res));
      }).fail(function(e) {
        console.log("failure: ", JSON.stringify(e));
      });

    });
  }

  return SnapController;

})();