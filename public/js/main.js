(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var Boot, Game, MainMenu, Preloader;

Boot = require('./Boot');

Preloader = require('./Preloader');

MainMenu = require('./MainMenu');

Game = require('./Game');

window.onload = function() {
  var game;
  game = new Phaser.Game(540, 960, Phaser.AUTO, 'gameContainer');
  window.game = game;
  game.state.add('Boot', Boot);
  game.state.add('Preloader', Preloader);
  game.state.add('MainMenu', MainMenu);
  game.state.add('Game', Game);
  return game.state.start('Boot');
};



},{"./Boot":2,"./Game":3,"./MainMenu":4,"./Preloader":5}],2:[function(require,module,exports){

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
var Game;

Game = (function() {
  function Game() {}

  return Game;

})();

module.exports = Game;



},{}],4:[function(require,module,exports){
var MainMenu;

MainMenu = (function() {
  function MainMenu(game) {
    console.log('MainMenu');
  }

  MainMenu.prototype.create = function() {};

  MainMenu.prototype.update = function() {};

  MainMenu.prototype.startGame = function() {
    return this.game.state.start('Game');
  };

  return MainMenu;

})();

module.exports = MainMenu;



},{}],5:[function(require,module,exports){
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



},{}]},{},[1]);
