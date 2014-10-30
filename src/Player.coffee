class Player
  constructor: (@id)->
  	@points = 0
  	@words = []

  addWord: (word) ->
  	@words.push word

  addPoints: (num) ->
  	@points += num

module.exports = Player
