Player       = require './Player'
TextInput    = require './TextInput'

class MainMenu
  constructor: (@game) ->
    @start = false

  create: ->
    @textBox = new TextInput(@game)
    @textBox.on 'submit', (name) =>
      @game.socket.emit 'new player', name
      @start = true
      @startGame()

  update: ->

  shutdown: ->
    @textBox.destroy()

  startGame: ->
    @game.state.start 'Game'


module.exports = MainMenu
