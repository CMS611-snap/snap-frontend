{EventEmitter} = require 'events'

inputBoxTemplate = require '../views/templates/inputBox.jade'

class TextInput extends EventEmitter
  constructor: (game) ->
    inputBoxHTML = inputBoxTemplate()
    $('#overlay').append(inputBoxHTML)
                 .promise()
                 .done => @setupKeyInput()


  setupKeyInput: ->
    console.log 'set it up'
    #@$inputBox = $(inputBoxHTML)
    #@$inputBox.mouseover =>
    #  console.log 'barr'

  go: ->
    @emit 'testing'

    # user EventEmitter to emit word when sumbited (jquery)

module.exports = TextInput


