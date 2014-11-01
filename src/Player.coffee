class Player
  constructor: (@id)->
  	@points = 0
  	@words = {}

  addWord: (word, phaserText) ->
    if !(word of @words)
      @words[word] = phaserText;

  addPoints: (num) ->
  	@points += num

module.exports = Player
