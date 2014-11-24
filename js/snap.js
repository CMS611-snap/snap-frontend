var socket =io('http://localhost:8080');
var playerName = ''
var score = 0

$( "#nameForm" ).submit(function( event ) {
    playerName = $('#name').val();
    socket.emit('new player', playerName);
});

$("#wordForm").submit(function(event){
    var word = $('#word').val();
    socket.emit('new word', word);
    $('#wordList').append('<span>'+word.toLowerCase()+'</span><br>');
    $('#word').val('');
    $("#wordList").animate({ scrollTop: $("#wordList").prop("scrollHeight")}, 100);
});

socket.on('snap', function(data) {
   score = score + data.d_score
   $('#wordList').html()
   $('#wordList').append('<span class="snappedWord">'+data.word+' ('+data.player+')</span><br>');
   $('#score').html(score);
});

socket.on('game over', function(data){
   $('#word').prop('disabled', true);
});

socket.on('user joined', function(data) {
    if (data.player === playerName){
        enterGameState();
    }
});

socket.on('game started', function(data) {
    //start client timer here
    $('#word').removeAttr('disabled');
});

function enterGameState() {
    $( "#nameForm" ).fadeOut( "slow", function() {
        $('#gameState').css('visibility', 'visible');
        $('#gameState').css('height','auto');
    });
}
