Player       = require './Player'
TextInput    = require './TextInput'
EventEmitter = require('events').EventEmitter

class Game extends EventEmitter
  constructor: (game) ->
    window.game = @
    @textBox = new TextInput(game)
    @textBox.on 'testing', -> console.log "got an event from input box"

    @player  = new Player(game)

    window.Game = @

    @socket = io.connect('https://snapgame.herokuapp.com', {secure: true})
    @socket.emit 'new player', 'name'

    @socket.on 'snap', (data) =>
      # update appropriate word for snap
      @player.addPoints(data.d_score)
      console.log data.d_score
      console.log "total points: #{@player.points}"
      $.notify "Snap! on #{data.word}"
      $.notify "You have #{@player.points} points", "info"

  create: ->

  sendWord: (word) ->
    console.log word
    @socket.emit 'new word', word

module.exports = Game
