class Viz
  constructor: (width, height) ->
    # create our two.js canvas
    @two = new Two({
                   width  : width,
                   height : height
                  })
module.exports = Viz
