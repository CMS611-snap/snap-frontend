class Player
  constructor: (@id)->
  	@points = 0
  	@wordlist = []

  addWord: (word) ->
  	@wordlist.push word

  addPoints: (num) ->
  	@points += num


module.exports = Player
