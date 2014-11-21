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

    #@joinGame 'player name'


  joinGame: (playerName) ->
    @socket = @setupSocket()

    @socket.emit 'new player', playerName
    @socket.on 'game started', (data) ->
      console.log 'game started'
    @socket.on 'game over', (data) ->
      console.log 'game over'


  setupSocket: ->
    if window.location.search.indexOf("local") != -1
        return io.connect('http://localhost:8080', {secure: false})
    else if window.location.search.indexOf("dev") != -1
        return io.connect('https://snap-backend-dev.herokuapp.com:443', {secure: true})
    else
        return io.connect('https://snapgame.herokuapp.com:443', {secure: true})

module.exports = Game
