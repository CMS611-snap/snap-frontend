Player       = require './Player'
TextInput    = require './TextInput'
WordsDisplay = require './WordsDisplay'

class Game
  constructor: (game) ->
    console.log 'Game'
    @game = game
    @playerName = null # set by the MainMenu

    @player  = new Player(game)

    if window.location.search.indexOf("local") != -1
        @socket = io.connect('http://localhost:8080', {secure: false})
    else
        @socket = io.connect('https://snapgame.herokuapp.com:443', {secure: true})

  create: (game) ->
    @scoreText = @game.add.text(400, 0, 'snaps: ', {font: '20px Arial', fill: '#ffffff'})

    @socket.emit 'new player', @playerName
    @socket.on 'snap', (data) =>
      # update appropriate word for snap
      @player.addPoints data.d_score
      @wordsDisplay.addWord("#{data.word} +#{data.d_score} (#{data.player})", '#00ff00')
      @animateSnap(data.word)
      @scoreText.text = "snaps: #{@player.points}"

    @socket.on 'game over', (data) =>
      @player.reset()
      @wordsDisplay.addWord('game over', '#0000ff')
      @wordsDisplay.addWord("the winner(s) are: #{data.winners.join(' and ')}", '#ffffff')
      @wordsDisplay.addWord('next round begins now', '#0000ff')


    @wordsDisplay = new WordsDisplay(game)
    @textBox      = new TextInput(game)
    @textBox.setPosition(600, 60)
    @textBox.on 'submit', (word) =>
      @sendWord word


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
