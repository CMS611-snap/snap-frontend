Viz    = require './Viz'
Player = require './Player'

class Game
  constructor: ->
    @players = {}
    @player  = null
    @topic   = ''

    @viz = new Viz(500, 500)
    @viz.two.appendTo $("#viz").get(0)

    $('#nameForm').submit (evt) =>
      evt.preventDefault()
      @joinGame $('#name').val()

    $('#wordForm').submit (evt) =>
      evt.preventDefault()
      @sendWord $('#word').val()

    @socket = @setupSocket()
    @socket.on 'new topic', (data) =>
      @topic = data
      $('#info').fadeOut 400, =>
          $('#info').html('<strong>Topic set to:</strong> ' + @topic).fadeIn(500)
      $('#wordListInfo').hide()
      $('#wordListInfo').html('<strong>Your words will appear here:</strong>')
      $('#wordListInfo').fadeIn(500)


  joinGame: (playerName) ->
    @player = new Player(@viz.two, playerName, "#00FF00")
    $('#info').fadeOut 400, ->
      $('#info').html('<strong> Hi '+playerName+',</strong> important information will appear here.').fadeIn(500)
    $( "#nameForm" ).fadeOut 400, ->
        $('#gameState').css('visibility', 'visible')
        $('#gameState').hide()
        $('#gameState').css('height','auto')
        $('#gameState').fadeIn(500)

    @socket.emit 'new player', playerName

    @socket.on 'game started', (data) =>
      console.log data
      #start client timer here
      $('#word').removeAttr('disabled')
      $('#info').fadeOut 200, =>
          $('#info').html('<strong> Game has started! </strong> Go go go! Topic is '+ @topic+'.').fadeIn(300)
      for player in data.players
        @players[player] = new Player(@viz.two, player)

    @socket.on 'game over', (data) ->
      #TODO state winners
      $('#word').prop('disabled', true)

    @socket.on 'snap', (data) =>
      score = data.d_score
      @player.addPoints score
      @player.snap(@players[data.player])
      # Play a random snap sound
      sound = "#snap" + Math.floor(Math.random() * 12)
      console.log sound
      $(sound).trigger("play")
      $('#wordList').html()
      $('#wordList').append('<span class="snappedWord">'+data.word+' ('+data.player+')</span><br>')
      $('#score').html(@player.snaps)

    @socket.on 'disconnect', () =>
      location.reload()

  sendWord: (word) ->
    @socket.emit 'new word', word
    $('#wordList').append('<span>'+word.toLowerCase()+'</span><br>')
    $('#word').val('')
    $("#wordList").animate({ scrollTop: $("#wordList").prop("scrollHeight")}, 100)

  setupSocket: ->
    if window.location.search.indexOf("local") != -1
        return io.connect('http://localhost:8080', {secure: false})
      else if window.location.search.indexOf("dev") != -1
        return io.connect('https://snap-backend-dev.herokuapp.com:443', {secure: true})
      else
        return io.connect('https://snapgame.herokuapp.com:443', {secure: true})

module.exports = Game
