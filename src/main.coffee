window.onload = ->
  Game  = require './Game'
  TWEEN = require 'tween.js'

  game = new Game()

  animate = (time) ->
    requestAnimationFrame(animate)
    TWEEN.update(time)
    game.viz.two.update()
  animate()

  console.log 'good to go'
