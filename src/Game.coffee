Player    = require './Player'
TextInput = require './TextInput'

class Game
  constructor: (game) ->
    @textBox = new TextInput(game)
    @player  = new Player(game)

    ### TODO get this working with the server
    @socket  = io.connect('link to server socket')
    @socket.on 'snap', (data) =>
      # update appropriate word for snap
    ###

  create: ->
    console.log @game

  sendWords: ->
    @socket.emit 'words', @player.words

module.exports = Game
