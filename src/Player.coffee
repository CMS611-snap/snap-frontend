class Player
  constructor: (@game)->
    @points = 0
    @words = []

  addWord: (word) ->
    @words.push word

  addPoints: (num) ->
    @points += num
    console.log "POINTS: " + @points

module.exports = Player
