Player       = require './Player'
TextInput    = require './TextInput'

class Game
  constructor: (game) ->
    console.log 'Game'

    @textBox = new TextInput(game)
    @textBox.on 'submit', (word) =>
      @sendWord word

    @player  = new Player(game)

    ###
    @socket = io.connect('https://snapgame.herokuapp.com', {secure: true})
    @socket.emit 'new player', 'name'

    @socket.on 'snap', (data) =>
      # update appropriate word for snap
      @player.addPoints(data.d_score)
      console.log data.d_score
      console.log "total points: #{@player.points}"
      $.notify "Snap! on #{data.word}"
      $.notify "You have #{@player.points} points", "info"
    ###

  create: ->

  sendWord: (word) ->
    @socket.emit 'new word', word

module.exports = Game
