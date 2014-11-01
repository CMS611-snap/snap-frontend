class WordsDisplay
  
  constructor: (@game, @player) ->
    @elem = @game.add.group();
    @spacing = 30;

  addWord: (word, color, addToPlayer) ->
    spacing = @spacing;
    @elem.forEach (text) ->
      text.y -= spacing;

    text = new Phaser.Text(@game, 
                           0, 
                           @game.height - @spacing, 
                           word, 
                           {font: '20px Arial', fill: color});

    if addToPlayer
      @player.addWord(word, text);

    @elem.add(text);

    highlightSnapped: (word) ->
      if word of @player.words
        @player.words[word].fill = "#77ff77";

module.exports = WordsDisplay;
