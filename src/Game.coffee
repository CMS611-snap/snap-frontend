Player       = require './Player'
TextInput    = require './TextInput'
WordsDisplay = require './WordsDisplay'

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
      @player.addPoints data.d_score
      @wordsDisplay.addWord("#{data.word} +#{data.d_score}", '#00ff00')

  create: (game) ->
    @wordsDisplay = new WordsDisplay(game)

  sendWord: (word) ->
    if word in @player.words
      @wordsDisplay.addWord(word, '#ff0000')
    else
      @player.addWord word
      @socket.emit 'new word', word
      @wordsDisplay.addWord(word, '#ffffff')

module.exports = Game
