Player    = require './Player'
TextInput = require './TextInput'

class Game
  constructor: (game) ->
    @textBox = new TextInput(game)
    @player  = new Player(game)

    @socket  = io.connect('https://snapgame.herokuapp.com/')
    @socket.emit  'new player'

    @socket.on 'snap', (data) =>
      # update appropriate word for snap

  create: ->
    console.log @game

  sendWord: (word) ->
    @socket.emit 'new word', word

module.exports = Game
