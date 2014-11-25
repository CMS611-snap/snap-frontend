//var socket =io('http://localhost:8080');
//var playerName = ''
//var score = 0
//var topic = ''
//$( "#nameForm" ).submit(function( event ) {
//    playerName = $('#name').val();
//    socket.emit('new player', playerName);
//    $('#info').fadeOut(400, function() {
//      $('#info').html('<strong> Hi '+playerName+',</strong> important information will appear here.').fadeIn(500);
//      });
//});
//
//$("#wordForm").submit(function(event){
//    var word = $('#word').val();
//    socket.emit('new word', word);
//    $('#wordList').append('<span>'+word.toLowerCase()+'</span><br>');
//    $('#word').val('');
//    $("#wordList").animate({ scrollTop: $("#wordList").prop("scrollHeight")}, 100);
//});
//
//socket.on('snap', function(data) {
//   score = score + data.d_score
//   $('#wordList').html()
//   $('#wordList').append('<span class="snappedWord">'+data.word+' ('+data.player+')</span><br>');
//   $('#score').html(score);
//});
//
//socket.on('game over', function(data){
//   $('#word').prop('disabled', true);
//});
//
//socket.on('user joined', function(data) {
//    if (data.player === playerName){
//        enterGameState();
//    }
//});
//
//socket.on('new topic', function(data) {
//    topic = data
//    $('#info').fadeOut(400, function() {
//        $('#info').html('<strong>Topic set to:</strong> '+topic).fadeIn(500);
//    });
//    $('#wordListInfo').hide();
//    $('#wordListInfo').html('<strong>Your words will appear here:</strong>');
//    $('#wordListInfo').fadeIn(500);
//});
//
//socket.on('game started', function(data) {
//    //start client timer here
//    $('#word').removeAttr('disabled');
//    $('#info').fadeOut(200, function() {
//        $('#info').html('<strong> Game has started! </strong> Go go go! Topic is '+topic+'.').fadeIn(300);
//    });
//});
//
//function enterGameState() {
//    $( "#nameForm" ).fadeOut( 400, function() {
//        $('#gameState').css('visibility', 'visible');
//        $('#gameState').hide();
//        $('#gameState').css('height','auto');
//        $('#gameState').fadeIn(500);
//    });
//}
