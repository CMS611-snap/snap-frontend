TWEEN  = require 'tween.js'
RADIUS = 3

class Player
  constructor: (@two, @name, @id, color) ->
    @words = {}
    @word_count = 0
    @pos   = { x: 0, y: $('#viz').height()-10}
    @score = 0
    circle = @two.makeCircle(0, 0, RADIUS)
    circle.fill = color || "#000000"
    circle.opacity = if color then 1 else 0.6
    circle.noStroke()
    @circle = @two.makeGroup(circle)
    @draw()

  draw: ->
    @circle.translation.set(@pos.x, @pos.y)
    @two.update()

  reset: () =>
    @words = {}
    @score = 0

  remove: () =>
    @circle.remove()

  addPoints: (pts) ->
    @score += pts

  addWord: (word) =>
    if not @words[word]?
      @word_count++
    @words[word] = true


  move: (yPos) ->
    # TODO(sdrammis): animate the y position to yPos
    @pos.y = yPos
    @draw()

  moveX: (relXPos) ->
    @pos.x = Math.floor(relXPos * 400)
    if @pos.x < RADIUS
      @pos.x = RADIUS
    if @pos.x > 400 - RADIUS
      @pos.x = 400 - RADIUS
    @draw()

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

  snapAnim: (word,playerList) =>
    if playerList.length >= 3
      info = 'snap '+word+ ' with '+playerList.length+' players'
    else
      info = 'snap '+word+ ' with '+playerList.join(', ')
    snapAlert = $('<div />').appendTo('#main')
    snapAlert.attr('id','snapAlert')
    $('#snapAlert').append('<p><span style=\'font-weight:bold\'>'+info+'</span></p>')
    $('#snapAlert').css({
      'display':'none',
      'top':'300px',
      'width':'50%', 'margin':'0 auto',
      'text-align':'center'})

    fadeIn = new TWEEN.Tween(snapAlert)
                      .to({},1000)
                      .onUpdate(=>$('#snapAlert').css('display','inline'))
    fadeOut = new TWEEN.Tween(snapAlert)
                      .to({},1000)
                      .onUpdate(=>$('#snapAlert').remove())
    fadeIn.chain(fadeOut)

    fadeIn.start()

    

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
