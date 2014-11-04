Player       = require './Player'
TextInput    = require './TextInput'

class MainMenu
  constructor: (@game) ->
    @socket = io.connect('https://snapgame.herokuapp.com', {secure: true})
    @start = false

  create: ->
    @textBox = new TextInput(@game)
    @textBox.on 'submit', (name) =>
    	@socket.emit 'new player', name
    	@start = true
    	@startGame()

  update: ->

  shutdown: ->
    @textBox.destroy()

  startGame: ->
    @game.state.start 'Game'


module.exports = MainMenu
