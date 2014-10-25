class Player
  constructor: (@id)->
  	@point = 0
  	@wordlist = []

  addWord: (word) ->
  	@wordlist.push word

  addPoint: (num) ->
  	@point += num


module.exports = Player
