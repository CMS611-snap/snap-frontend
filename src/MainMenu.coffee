Player       = require './Player'
TextInput    = require './TextInput'

class MainMenu
  constructor: (game) ->
    @game = game
    @textBox = new TextInput(game)
    @socket = io.connect('https://snapgame.herokuapp.com', {secure: true})
    @start = false
    @textBox.on 'submit', (name) =>
    	@socket.emit 'new player', name
    	@start = true
    	@startGame()

  create: ->

  update: ->


  startGame: ->
    @game.state.start 'Game'

module.exports = MainMenu
