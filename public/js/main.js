(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var Boot, Game, MainMenu, Preloader;

Boot = require('./Boot');

Preloader = require('./Preloader');

MainMenu = require('./MainMenu');

Game = require('./Game');

window.onload = function() {
  var game;
  game = new Phaser.Game(540, 960, Phaser.AUTO, 'gameContainer');
  game.state.add('Boot', Boot);
  game.state.add('Preloader', Preloader);
  game.state.add('MainMenu', MainMenu);
  game.state.add('Game', Game);
  return game.state.start('Boot');
};



},{"./Boot":2,"./Game":3,"./MainMenu":4,"./Preloader":6}],2:[function(require,module,exports){

/*
Bootloader performs additional phaser configuration options
and prepares the pre-loader assets.
 */
var Boot;

Boot = (function() {
  function Boot(game) {
    console.log('Boot');
  }

  Boot.prototype.preload = function() {};

  Boot.prototype.create = function() {
    this.input.maxPointers = 1;
    this.stage.disableVisibilityChange = false;
    this.input.addPointer();
    return this.game.state.start('Preloader');
  };

  return Boot;

})();

module.exports = Boot;



},{}],3:[function(require,module,exports){
var Game, Player, TextInput;

Player = require('./Player');

TextInput = require('./TextInput');

Game = (function() {
  function Game(game) {
    this.textBox = new TextInput(game);
    this.player = new Player(game);

    /* TODO get this working with the server
    @socket  = io.connect('link to server socket')
    @socket.on 'snap', (data) =>
       * update appropriate word for snap
     */
  }

  Game.prototype.create = function() {
    return console.log(this.game);
  };

  Game.prototype.sendWords = function() {
    return this.socket.emit('words', this.player.words);
  };

  return Game;

})();

module.exports = Game;



},{"./Player":5,"./TextInput":7}],4:[function(require,module,exports){
var MainMenu;

MainMenu = (function() {
  function MainMenu(game) {
    console.log('MainMenu');
  }

  MainMenu.prototype.create = function() {
    return this.startGame();
  };

  MainMenu.prototype.update = function() {};

  MainMenu.prototype.startGame = function() {
    return this.game.state.start('Game');
  };

  return MainMenu;

})();

module.exports = MainMenu;



},{}],5:[function(require,module,exports){
var Player;

Player = (function() {
  function Player() {}

  return Player;

})();

module.exports = Player;



},{}],6:[function(require,module,exports){
var Preloader;

Preloader = (function() {
  function Preloader(game) {
    this.preloadBar = null;
    this.titleText = null;
    this.ready = false;
    console.log('Preload');
  }

  Preloader.prototype.preload = function() {};

  Preloader.prototype.update = function() {
    this.ready = true;
    return this.game.state.start('MainMenu');
  };

  return Preloader;

})();

module.exports = Preloader;



},{}],7:[function(require,module,exports){
var TextInput;

TextInput = (function() {
  var local;

  local = {};

  function TextInput(game) {
    local.game = game;
    console.log('TextInput');
  }

  TextInput.prototype.create = function() {};

  TextInput.prototype.update = function() {};

  return TextInput;

})();

module.exports = TextInput;



},{}]},{},[1])
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlc1xcYnJvd3NlcmlmeVxcbm9kZV9tb2R1bGVzXFxicm93c2VyLXBhY2tcXF9wcmVsdWRlLmpzIiwiYzpcXFVzZXJzXFxEc2FuMTBzXFxEcm9wYm94IChNSVQpXFxHaXRodWJcXDYuMDczXFw2LjA3My1Qcm9qZWN0LTNcXHNuYXAtZnJvbnRlbmRcXHNyY1xcbWFpbi5jb2ZmZWUiLCJjOlxcVXNlcnNcXERzYW4xMHNcXERyb3Bib3ggKE1JVClcXEdpdGh1YlxcNi4wNzNcXDYuMDczLVByb2plY3QtM1xcc25hcC1mcm9udGVuZFxcc3JjXFxCb290LmNvZmZlZSIsImM6XFxVc2Vyc1xcRHNhbjEwc1xcRHJvcGJveCAoTUlUKVxcR2l0aHViXFw2LjA3M1xcNi4wNzMtUHJvamVjdC0zXFxzbmFwLWZyb250ZW5kXFxzcmNcXEdhbWUuY29mZmVlIiwiYzpcXFVzZXJzXFxEc2FuMTBzXFxEcm9wYm94IChNSVQpXFxHaXRodWJcXDYuMDczXFw2LjA3My1Qcm9qZWN0LTNcXHNuYXAtZnJvbnRlbmRcXHNyY1xcTWFpbk1lbnUuY29mZmVlIiwiYzpcXFVzZXJzXFxEc2FuMTBzXFxEcm9wYm94IChNSVQpXFxHaXRodWJcXDYuMDczXFw2LjA3My1Qcm9qZWN0LTNcXHNuYXAtZnJvbnRlbmRcXHNyY1xcUGxheWVyLmNvZmZlZSIsImM6XFxVc2Vyc1xcRHNhbjEwc1xcRHJvcGJveCAoTUlUKVxcR2l0aHViXFw2LjA3M1xcNi4wNzMtUHJvamVjdC0zXFxzbmFwLWZyb250ZW5kXFxzcmNcXFByZWxvYWRlci5jb2ZmZWUiLCJjOlxcVXNlcnNcXERzYW4xMHNcXERyb3Bib3ggKE1JVClcXEdpdGh1YlxcNi4wNzNcXDYuMDczLVByb2plY3QtM1xcc25hcC1mcm9udGVuZFxcc3JjXFxUZXh0SW5wdXQuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUEsSUFBQSwrQkFBQTs7QUFBQSxJQUFBLEdBQVksT0FBQSxDQUFRLFFBQVIsQ0FBWixDQUFB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R0FBQTtBQUNYLElBQUEsS0FBSyxDQUFDLElBQU4sR0FBYSxJQUFiLENBQUE7QUFBQSxJQUNBLE9BQU8sQ0FBQyxHQUFSLENBQVksV0FBWixDQURBLENBRFc7RUFBQSxDQUZiOztBQUFBLHNCQU1BLE1BQUEsR0FBUSxTQUFBLEdBQUEsQ0FOUixDQUFBOztBQUFBLHNCQVFBLE1BQUEsR0FBUSxTQUFBLEdBQUEsQ0FSUixDQUFBOzttQkFBQTs7SUFGRixDQUFBOztBQUFBLE1BWU0sQ0FBQyxPQUFQLEdBQWlCLFNBWmpCLENBQUEiLCJmaWxlIjoiZ2VuZXJhdGVkLmpzIiwic291cmNlUm9vdCI6IiIsInNvdXJjZXNDb250ZW50IjpbIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dmFyIGY9bmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKTt0aHJvdyBmLmNvZGU9XCJNT0RVTEVfTk9UX0ZPVU5EXCIsZn12YXIgbD1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwobC5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxsLGwuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIiwiQm9vdCAgICAgID0gcmVxdWlyZSAnLi9Cb290J1xyXG5QcmVsb2FkZXIgPSByZXF1aXJlICcuL1ByZWxvYWRlcidcclxuTWFpbk1lbnUgID0gcmVxdWlyZSAnLi9NYWluTWVudSdcclxuR2FtZSAgICAgID0gcmVxdWlyZSAnLi9HYW1lJ1xyXG5cclxuXHJcbndpbmRvdy5vbmxvYWQgPSAtPlxyXG4gIGdhbWUgPSBuZXcgUGhhc2VyLkdhbWUoNTQwLCA5NjAsIFBoYXNlci5BVVRPLCAnZ2FtZUNvbnRhaW5lcicpXHJcblxyXG4gIGdhbWUuc3RhdGUuYWRkICdCb290JywgQm9vdFxyXG4gIGdhbWUuc3RhdGUuYWRkICdQcmVsb2FkZXInLCBQcmVsb2FkZXJcclxuICBnYW1lLnN0YXRlLmFkZCAnTWFpbk1lbnUnLCBNYWluTWVudVxyXG4gIGdhbWUuc3RhdGUuYWRkICdHYW1lJywgR2FtZVxyXG4gIGdhbWUuc3RhdGUuc3RhcnQgJ0Jvb3QnXHJcbiIsIiMjI1xyXG5Cb290bG9hZGVyIHBlcmZvcm1zIGFkZGl0aW9uYWwgcGhhc2VyIGNvbmZpZ3VyYXRpb24gb3B0aW9uc1xyXG5hbmQgcHJlcGFyZXMgdGhlIHByZS1sb2FkZXIgYXNzZXRzLlxyXG4jIyNcclxuY2xhc3MgQm9vdFxyXG4gIGNvbnN0cnVjdG9yOiAoZ2FtZSkgLT5cclxuICAgIGNvbnNvbGUubG9nICdCb290J1xyXG5cclxuICBwcmVsb2FkOiAtPlxyXG4gICMgbG9hZCBpbWFnZXMgZm9yIHRoZSBwcmVsb2FkZXJcclxuXHJcbiAgY3JlYXRlOiAtPlxyXG4gICAgQGlucHV0Lm1heFBvaW50ZXJzID0gMVxyXG4gICAgQHN0YWdlLmRpc2FibGVWaXNpYmlsaXR5Q2hhbmdlID0gZmFsc2VcclxuICAgIEBpbnB1dC5hZGRQb2ludGVyKClcclxuXHJcbiAgICAjIGxhdW5jaCBwcmVsb2FkZXJcclxuICAgIEBnYW1lLnN0YXRlLnN0YXJ0KCdQcmVsb2FkZXInKVxyXG5cclxubW9kdWxlLmV4cG9ydHMgPSBCb290XHJcbiIsIlBsYXllciAgICA9IHJlcXVpcmUgJy4vUGxheWVyJ1xyXG5UZXh0SW5wdXQgPSByZXF1aXJlICcuL1RleHRJbnB1dCdcclxuXHJcbmNsYXNzIEdhbWVcclxuICBjb25zdHJ1Y3RvcjogKGdhbWUpIC0+XHJcbiAgICBAdGV4dEJveCA9IG5ldyBUZXh0SW5wdXQoZ2FtZSlcclxuICAgIEBwbGF5ZXIgID0gbmV3IFBsYXllcihnYW1lKVxyXG5cclxuICAgICMjIyBUT0RPIGdldCB0aGlzIHdvcmtpbmcgd2l0aCB0aGUgc2VydmVyXHJcbiAgICBAc29ja2V0ICA9IGlvLmNvbm5lY3QoJ2xpbmsgdG8gc2VydmVyIHNvY2tldCcpXHJcbiAgICBAc29ja2V0Lm9uICdzbmFwJywgKGRhdGEpID0+XHJcbiAgICAgICMgdXBkYXRlIGFwcHJvcHJpYXRlIHdvcmQgZm9yIHNuYXBcclxuICAgICMjI1xyXG5cclxuICBjcmVhdGU6IC0+XHJcbiAgICBjb25zb2xlLmxvZyBAZ2FtZVxyXG5cclxuICBzZW5kV29yZHM6IC0+XHJcbiAgICBAc29ja2V0LmVtaXQgJ3dvcmRzJywgQHBsYXllci53b3Jkc1xyXG5cclxubW9kdWxlLmV4cG9ydHMgPSBHYW1lXHJcbiIsImNsYXNzIE1haW5NZW51XHJcbiAgY29uc3RydWN0b3I6IChnYW1lKSAtPlxyXG4gICAgY29uc29sZS5sb2cgJ01haW5NZW51J1xyXG5cclxuICBjcmVhdGU6IC0+XHJcbiAgICBAc3RhcnRHYW1lKClcclxuXHJcbiAgdXBkYXRlOiAtPlxyXG5cclxuICBzdGFydEdhbWU6IC0+XHJcbiAgICBAZ2FtZS5zdGF0ZS5zdGFydCAnR2FtZSdcclxuXHJcbm1vZHVsZS5leHBvcnRzID0gTWFpbk1lbnVcclxuIiwiY2xhc3MgUGxheWVyXHJcbiAgY29uc3RydWN0b3I6IC0+XHJcblxyXG5tb2R1bGUuZXhwb3J0cyA9IFBsYXllclxyXG4iLCJjbGFzcyBQcmVsb2FkZXJcclxuICBjb25zdHJ1Y3RvcjogKGdhbWUpIC0+XHJcbiAgICBAcHJlbG9hZEJhciA9IG51bGw7ICNUT0RPXHJcbiAgICBAdGl0bGVUZXh0ICA9IG51bGwgI1RPRE9cclxuICAgIEByZWFkeSA9IGZhbHNlXHJcbiAgICBjb25zb2xlLmxvZyAnUHJlbG9hZCdcclxuXHJcbiAgcHJlbG9hZDogLT5cclxuICAgICMgbG9hZCBzdGF0ZSBhc3NldHNcclxuXHJcbiAgdXBkYXRlOiAtPlxyXG4gICAgQHJlYWR5ID0gdHJ1ZVxyXG4gICAgQGdhbWUuc3RhdGUuc3RhcnQgJ01haW5NZW51J1xyXG5cclxubW9kdWxlLmV4cG9ydHMgPSBQcmVsb2FkZXJcclxuIiwiY2xhc3MgVGV4dElucHV0XHJcblxyXG4gIGxvY2FsID0ge31cclxuXHJcbiAgY29uc3RydWN0b3I6IChnYW1lKSAtPlxyXG4gICAgbG9jYWwuZ2FtZSA9IGdhbWVcclxuICAgIGNvbnNvbGUubG9nICdUZXh0SW5wdXQnXHJcblxyXG4gIGNyZWF0ZTogLT5cclxuXHJcbiAgdXBkYXRlOiAtPlxyXG5cclxubW9kdWxlLmV4cG9ydHMgPSBUZXh0SW5wdXRcclxuXHJcblxyXG4iXX0=
