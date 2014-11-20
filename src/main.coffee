window.onload = ->
  # create our two.js canvas
  two = new Two({
                 width  : 500,
                 height : 500
                })

  # add our two svg to the dom
  two.appendTo $("#main").get(0)

  # testing drawing of a circle
  circle = two.makeCircle(20, 20, 20)
  circle.fill = "#FF0000"
  two.update()
