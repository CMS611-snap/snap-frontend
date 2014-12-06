TWEEN  = require 'tween.js'
RADIUS = 3

class Player
  constructor: (@two, @name, @id, color) ->
    @words = {}
    @word_count = 0
    @opacity = if color then 1 else 0.6
    @color = color || "#000000"
    @pos   = { x: Math.random() * 200, y: Math.random() * 200}
    @score = 0
    @draw()

  draw: ->
    @two.remove @circle if @circle
    @circle = @two.makeCircle(@pos.x, @pos.y, RADIUS)
    @circle.fill    = @color
    @circle.opacity = @opacity
    @circle.noStroke()

  reset: () =>
    @words = {}
    @score = 0
    @draw()

  addPoints: (pts) ->
    @score += pts

  addWord: (word) =>
    if not @words[word]?
      @word_count++
    @words[word] = true

  snap: (player) ->
    # TODO: add players that join late so this doesn't happen
    if not player?
      return

    # draw a line from current player to other player
    line        = @two.makeLine(@pos.x, @pos.y, @pos.x, @pos.y)
    line.stroke = "rgba(0, 255, 0, 1)"

    # green circle for player that we snap with
    greenCircle = @two.makeCircle(player.pos.x, player.pos.y, RADIUS)
    greenCircle.fill    = "#00FF00"
    greenCircle.opacity = 0
    greenCircle.noStroke()

    dX   = player.pos.x - @pos.x
    dY   = player.pos.y - @pos.y
    drawLine = new TWEEN.Tween(line.vertices[1])
                        .to( {x: "#{dX}", y: "#{dY}"}, 400)
    hideLine = new TWEEN.Tween(line.vertices[0])
                        .to({x: "#{dX}", y: "#{dY}"}, 600)
                        .onComplete( => @two.remove(hideLine) )

    flashInCircle = new TWEEN.Tween(greenCircle)
                             .to( {opacity: 1}, 10)
    growCircle    = new TWEEN.Tween(greenCircle)
                             .easing(TWEEN.Easing.Quartic.Out)
                             .to( {scale: 1.5}, 300)

    shrinkCircle  = new TWEEN.Tween(greenCircle)
                             .to( {scale: 1}, 400)
    fadeOutCircle = new TWEEN.Tween(greenCircle)
                             .to( {opacity: 0}, 1000)
                             .onComplete( => @two.remove(greenCircle) )

    drawLine.chain(flashInCircle)
    flashInCircle.chain(growCircle)
    growCircle.chain(hideLine)
    hideLine.chain(shrinkCircle)
    shrinkCircle.chain(fadeOutCircle)

    drawLine.start()

  snapSubtle: (player) ->
    # draw a line from current player to other player
    line        = @two.makeLine(@pos.x, @pos.y, @pos.x, @pos.y)
    line.stroke = "rgba(0, 0, 0, 0.5)"
    dX   = ( player.pos.x - @pos.x ) / 2
    dY   = ( player.pos.y - @pos.y ) / 2
    drawLine = new TWEEN.Tween(line.vertices[1])
                        .to( {x: "#{dX}", y: "#{dY}"}, 700)
    hideLine = new TWEEN.Tween(line)
                        .to({opacity: 0}, 800)
                        .onComplete( => @two.remove(hideLine) )
    drawLine.chain(hideLine)
    drawLine.start()

module.exports = Player
