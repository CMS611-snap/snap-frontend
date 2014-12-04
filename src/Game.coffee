Viz    = require './Viz'
Player = require './Player'

class Game
  constructor: ->
    @players = {}
    @player  = null
    @topic   = ''
    width = $('#col2').width()
    height = $('#col2').height()
    @viz = new Viz(width, height)
    @viz.two.appendTo $("#viz").get(0)

    $('#nameForm').submit (evt) =>
      evt.preventDefault()
      @joinGame $('#name').val()

    $('#wordForm').submit (evt) =>
      evt.preventDefault()
      word = $('#word').val()
      if @player.addWord(word)
        @sendWord(word)
        $('#word').removeClass('usedWord')
      else
        $('#word').addClass('usedWord')
        $("#wordWrapper").effect('shake', {distance: 10})

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
        $('#gameState').fadeIn(500)

    @socket.emit 'new player', playerName

    @socket.on 'game started', (data) =>
      console.log data
      #start client timer here
      $('#word').removeAttr('disabled')
      $('#info').fadeOut 200, =>
          $('#info').html('<strong> Game has started! </strong> Go go go! Topic is '+ @topic+'.').fadeIn(300)
      for player in data.players
        @players[player.uuid] = new Player(@viz.two, player.name)

    @socket.on 'game over', (data) ->
      winners = data.winners.map((p) -> p.name).join(', ')
      
      $('#info').fadeOut 200, =>
          $('#info').html('<strong> Game Over! </strong> Congratulations to winners: '+ "<marquee>#{winners}</marquee>").fadeIn(300)
      $('#word').prop('disabled', true)

    @socket.on 'snap', (data) =>
      @player.addPoints data.d_score
      snappedPlayers = data.player.filter (p) => p.name isnt @player.name
      for player in snappedPlayers
        @player.snap(@players[player.uuid])
      playerNames = snappedPlayers.map (p) -> p.name

      # Play a random snap sound
      sound = "#snap" + Math.floor(Math.random() * 12)
      $(sound).trigger("play")

      $('#wordList').append("<span class=\"snappedWord\"> #{data.word} (#{playerNames.join(', ')})</span><br />")
      $('#score').html(@player.score)

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
