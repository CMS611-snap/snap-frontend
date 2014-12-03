class Viz
  constructor: (width, height) ->
    # create our two.js canvas
    @two = new Two({
                   width  : width,
                   height : height
                  })

  getYPosition: (percentile) ->
    return percentile  * @two.height

module.exports = Viz
