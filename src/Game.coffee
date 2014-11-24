Viz    = require './Viz'
Player = require './Player'

class Game
  constructor: ->
    @players = {}
    @player  = null

    @viz = new Viz(500, 500)
    @viz.two.appendTo $("#viz").get(0)


    for i in [0...2]
      @players[i] = new Player(@viz.two, 'name')

    @players[0].snap(@players[1])

    @joinGame 'sabrina' # FIXME this should be the player's name

    $wordInput = $('#wordInput')
    $wordInput.keyup (evt) =>
      @sendWord $wordInput.val() if evt.keyCode is 13

  joinGame: (playerName) ->
    @player = new Player(@viz.two, playerName, "#00FF00")
    @socket = @setupSocket()

    @socket.emit 'new player', playerName

    @socket.on 'game started', (data) =>
      console.log 'game started'
      console.log data.players.length
      for player in data.players
        @players[player] = new Player(@viz.two, player)

    @socket.on 'game over', (data) ->
      # TODO
      console.log 'game over'

    @socket.on 'snap', (data) =>
      console.log 'snap'
      @player.addPoints data.d_score
      @player.snap(@players[data.player])


  sendWord: (word) ->
    @socket.emit 'new word', word

  setupSocket: ->
    if window.location.search.indexOf("local") != -1
        return io.connect('http://localhost:8080', {secure: false})
    else if window.location.search.indexOf("dev") != -1
        return io.connect('https://snap-backend-dev.herokuapp.com:443', {secure: true})
    else
        return io.connect('https://snapgame.herokuapp.com:443', {secure: true})

module.exports = Game
