class MainMenu
  constructor: (game) ->
    console.log 'MainMenu'

  create: ->
    console.log @game.input
    @startGame()

  update: ->

  startGame: ->
    @game.state.start 'Game'

module.exports = MainMenu
