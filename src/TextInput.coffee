{EventEmitter} = require 'events'

inputBoxTemplate = require '../views/templates/inputBox.jade'

class TextInput extends EventEmitter
  constructor: (game) ->
    # get the inputBox view template
    inputBoxHTML = inputBoxTemplate()
    @$inputBox    = $(inputBoxHTML)

    # add input box to the DOM
    @$inputBox.appendTo '#overlay'

    # on enter, emit the word to be submited to server
    @$inputBox.keypress (evt) =>
      if evt.which is 13
        @emit 'submit', @getValue()
        @setValue ""

  setPosition: (top, left) ->
    @$inputBox.css 'top', top
    @$inputBox.css 'left', left

  destroy: ->
    @$inputBox.remove()

  getValue: ->
    return @$inputBox.val()

  setValue: (value) ->
    @$inputBox.val value

module.exports = TextInput


