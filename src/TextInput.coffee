{EventEmitter} = require 'events'

inputBoxTemplate = require '../views/templates/inputBox.jade'

class TextInput extends EventEmitter
  constructor: (game) ->
    inputBoxHTML = inputBoxTemplate()
    $inputBox    = $(inputBoxHTML)
    $inputBox.appendTo('#overlay')
    $inputBox.keypress (evt) =>
      if evt.which is 13
        @emit 'testing'

module.exports = TextInput


