TWEEN = require 'tween.js'

class Player
  constructor: (@two, name, color) ->
    @color = color || 0x000000
    @pos   = { x: Math.random() * 500, y: Math.random() * 500 }
    @drawTo()

  drawTo: ->
    c = @two.makeCircle(@pos.x, @pos.y, 3)
    c.fill = @color

  # draw a line from current player to other player
  snap: (player) ->
    line = @two.makeLine(@pos.x, @pos.y, @pos.x, @pos.y)

    dX = player.pos.x - @pos.x
    dY = player.pos.y - @pos.y
    new TWEEN.Tween(line.vertices[1])
             .to( {x: "#{dX}", y: "#{dY}"}, 400)
             .start()


module.exports = Player
