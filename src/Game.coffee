Player       = require './Player'
TextInput    = require './TextInput'
WordsDisplay = require './WordsDisplay'

class Game
  constructor: (game) ->
    @game = game

    @player  = new Player(game)
    @textBox = new TextInput(game)

    @textBox.on 'submit', (word) =>
      @sendWord word

    @socket = io.connect('https://snapgame.herokuapp.com', {secure: true})
    @socket.emit 'new player', 'name'

    @socket.on 'snap', (data) =>
      # update appropriate word for snap
      @player.addPoints data.d_score
      @wordsDisplay.addWord("#{data.word} +#{data.d_score}", '#00ff00')
      @animateSnap(data.word)

  create: (game) ->
    @wordsDisplay = new WordsDisplay(game)

  sendWord: (word) ->
    if word in @player.words
      @wordsDisplay.addWord(word, '#ff0000')
    else
      @player.addWord word
      @socket.emit 'new word', word
      @wordsDisplay.addWord(word, '#ffffff')

  animateSnap: (word) ->
    snapMsg = @game.add.text(200, 200, 'SNAP', {font: '30px Arial', fill: '#00ff00'})
    snapMsg.anchor = {x: 0.5, y:0.5}
    snapMsg.scale.x = 0
    snapMsg.scale.y = 0
    scaleIn = @game.add.tween(snapMsg.scale)
                   .to({x: 1, y: 1}, 1000)
                   .easing(Phaser.Easing.Elastic.Out)

    alphaOut = @game.add.tween(snapMsg)
                    .delay(500)
                    .to({alpha: 0}, 200)
                    .easing(Phaser.Easing.Quadratic.In)

    destroyMsg = ->
      snapMsg.destroy()
      scaleIn.destory()
      alphaOut.destroy()
    alphaOut._lastChild.onComplete.add( -> destroyMsg )

    scaleIn.chain(alphaOut)
           .start()

module.exports = Game
