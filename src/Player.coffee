class Player
  constructor: (@game)->
    @reset()

  addWord: (word) ->
    @words.push word

  addPoints: (num) ->
    @points += num
    console.log "POINTS: " + @points

  reset: ->
    @points = 0
    @words  = []

module.exports = Player
