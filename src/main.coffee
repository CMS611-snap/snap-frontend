Boot      = require './Boot'
Preloader = require './Preloader'
MainMenu  = require './MainMenu'
Game      = require './Game'


window.onload = ->
  game = new Phaser.Game(540, 960, Phaser.AUTO, 'gameContainer')
  window.game = game

  game.state.add 'Boot', Boot
  game.state.add 'Preloader', Preloader
  game.state.add 'MainMenu', MainMenu
  game.state.add 'Game', Game
  game.state.start 'Boot'
