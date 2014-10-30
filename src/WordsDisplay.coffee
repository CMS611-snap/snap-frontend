SPACING = 30
class WordsDisplay
  constructor: (@game) ->
    @elem = @game.add.group()

  addWord: (word, color) ->
    @elem.forEach (text) ->
      text.y -= SPACING

    text = new Phaser.Text(@game, 0, @game.height - SPACING, word, {font: '20px Arial', fill: color})
    @elem.add(text)

module.exports = WordsDisplay
