###
Bootloader performs additional phaser configuration options
and prepares the pre-loader assets.
###
class Boot
  constructor: (game) ->
    console.log 'Boot'

  preload: ->
  # load images for the preloader

  create: ->
    @input.maxPointers = 1
    @stage.disableVisibilityChange = false
    @input.addPointer()

    # launch preloader
    @game.state.start('Preloader')

module.exports = Boot
