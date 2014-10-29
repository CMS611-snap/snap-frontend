Player       = require './Player'
TextInput    = require './TextInput'

class Game
  constructor: (game) ->

    @player  = new Player(game)
    @textBox = new TextInput(game)
    @textBox.on 'submit', (word) =>
      @sendWord word


    @socket = io.connect('http://localhost:8080', {secure: true})
    @socket.emit 'new player', 'name'

    @socket.on 'snap', (data) =>
      # update appropriate word for snap
      @player.addPoints(data.d_score)
      console.log "snap on: #{data.word}"
      console.log "total points: #{@player.points}"
      @wordsElem.text = @wordsElem.text + "#{data.word}\n"

  create: (game) ->
    @wordsElem = game.add.text(game.world.centerX, 0, 'testing\n', {font: '30px Arial', fill: "#ffffff"})

  sendWord: (word) ->
    @socket.emit 'new word', word

module.exports = Game
