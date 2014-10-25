Player  = require './Player'
TextBox = require './TextBox'

class Game
  constructor: (game) ->
    @textBox = new TextBox(game)
    @player  = new Player(game)

  create: ->
    console.log @game

module.exports = Game
