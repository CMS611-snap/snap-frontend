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
      Game.player.addWord(data[0].value);
      Game.sendWords();

    });
  }

  return SnapController;

})();