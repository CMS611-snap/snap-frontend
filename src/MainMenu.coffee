class MainMenu
  constructor: (game) ->
    console.log 'MainMenu'

  create: ->

  update: ->

  startGame: ->
    @game.state.start 'Game'

module.exports = MainMenu
