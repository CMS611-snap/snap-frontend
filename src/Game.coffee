Player       = require './Player'
TextInput    = require './TextInput'

class Game
  constructor: (game) ->
    console.log 'Game'

    @textBox = new TextInput(game)
    @textBox.on 'submit', (word) =>
      @sendWord word

    @player  = new Player(game)

    @socket = io.connect('http://localhost:8080', {secure: true})
    @socket.emit 'new player', 'name'

    @socket.on 'snap', (data) =>
      # update appropriate word for snap
      @player.addPoints(data.d_score)
      console.log "snap on: #{data.word}"
      console.log "total points: #{@player.points}"

  create: ->

  sendWord: (word) ->
    @socket.emit 'new word', word

module.exports = Game
