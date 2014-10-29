EventEmitter = require('events').EventEmitter

inputBoxTemplate = require '../views/templates/inputBox.jade'

class TextInput extends EventEmitter
  constructor: (game) ->
    @elem = inputBoxTemplate()
    @emitter = new EventEmitter()
    @.emit 'testing'

    # user EventEmitter to emit word when sumbited (jquery)

module.exports = TextInput


