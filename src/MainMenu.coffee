Player       = require './Player'
TextInput    = require './TextInput'

class MainMenu
  constructor: (@game) ->
    @start = false

  create: () ->
    @game.add.text(0, 0, "snaps: ", {font: '30px Arial', '#ffffff'})

    @textBox = new TextInput(@game)
    @textBox.on 'submit', (name) =>
      @start = true
      @startGame(name)

  update: ->

  shutdown: ->
    @textBox.destroy()

  startGame: (playerName) ->
    # TODO this is hacky, make it cleaner
    @game.state.states['Game'].playerName = playerName
    @game.state.start 'Game'


module.exports = MainMenu
