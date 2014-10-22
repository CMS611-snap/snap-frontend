class Preloader
  constructor: (game) ->
    @preloadBar = null; #TODO
    @titleText  = null #TODO
    @ready = false
    console.log 'Preload'

  preload: ->
    # load state assets

  update: ->
    @ready = true
    @game.state.start 'MainMenu'

module.exports = Preloader
