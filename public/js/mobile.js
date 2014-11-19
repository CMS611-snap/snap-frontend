$(function() {
  var name = null;

  $("#nameInput").keypress(function(e) {
    if (e.which === 13) {
      name = $("#nameInput").val();
      $("#nameForm").hide();
      return false;
    }
  });

});
