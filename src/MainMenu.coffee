class MainMenu
  constructor: (game) ->
    console.log 'MainMenu'

  create: ->
    @startGame()

  update: ->

  startGame: ->
    @game.state.start 'Game'

module.exports = MainMenu
