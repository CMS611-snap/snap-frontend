{EventEmitter} = require 'events'

inputBoxTemplate = require '../views/templates/inputBox.jade'

class TextInput extends EventEmitter
  constructor: (game) ->
    # get the inputBox view template
    inputBoxHTML = inputBoxTemplate()
    $inputBox    = $(inputBoxHTML)

    # add input box to the DOM
    $inputBox.appendTo('#overlay')

    # on enter, emit the word to be submited to server
    $inputBox.keypress (evt) =>
      if evt.which is 13
        @emit 'submit', $inputBox.val()
        $inputBox.val ""

module.exports = TextInput


