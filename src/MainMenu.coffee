Player       = require './Player'
TextInput    = require './TextInput'
Timer        = require './Timer'

class MainMenu
  constructor: (@game) ->
    @start = false

  create: () ->
    @game.add.text(0, 0, "snaps: ", {font: '30px Arial', '#ffffff'})
    @timer = new Timer(@game);
    @textBox = new TextInput(@game)
    @textBox.setPosition(300, 120) #TODO fix this
    @textBox.on 'submit', (name) =>
      @start = true
      @startGame(name)

    # TODO fix this
    @game.add.text(65, 200, 'Input your name and press enter to continue', {font: '20px Arial', fill: '#ffffff'})

  update: ->

  shutdown: ->
    @textBox.destroy()

  startGame: (playerName) ->
    # TODO this is hacky, make it cleaner
    @game.state.states['Game'].playerName = playerName
    @game.state.start 'Game'
    @timer.startInterval()

module.exports = MainMenu
