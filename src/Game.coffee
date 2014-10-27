Player    = require './Player'
TextInput = require './TextInput'

class Game
  constructor: (game) ->
    @textBox = new TextInput(game)
    @player  = new Player(game)

    window.Game = @

    @socket = io.connect('https://snapgame.herokuapp.com', {secure: true})
    @socket.emit 'new player', 'name'

    @socket.on 'snap', (data) =>
      # update appropriate word for snap
      @player.addPoints(data.d_score)
      console.log data.d_score
      console.log 'total points: ' + @player.points

  create: ->

  sendWord: (word) ->
    console.log word
    @socket.emit 'new word', word

module.exports = Game
