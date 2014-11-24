TWEEN  = require 'tween.js'
RADIUS = 3
class Player
  constructor: (@two, name, color) ->
    @color = color || "#000000"
    @pos   = { x: Math.random() * 500, y: Math.random() * 500 }
    @snaps = 0
    @draw()

  draw: ->
    @two.remove @circle if @circle
    @circle = @two.makeCircle(@pos.x, @pos.y, @snaps + RADIUS)
    @circle.fill = @color

  snap: (player) ->
    @snaps += 1
    @draw()

    # draw a line from current player to other player
    line = @two.makeLine(@pos.x, @pos.y, @pos.x, @pos.y)
    dX   = player.pos.x - @pos.x
    dY   = player.pos.y - @pos.y
    drawLine = new TWEEN.Tween(line.vertices[1])
                        .to( {x: "#{dX}", y: "#{dY}"}, 400)
    hideLine = new TWEEN.Tween(line)
                        .to({opacity: 0}, 500)
                        .onComplete( => @two.remove(hideLine) )
    drawLine.chain(hideLine)
    drawLine.start()

  addPoints: (pts) ->
    @snaps += pts
    console.log "score: " + @snaps

module.exports = Player
