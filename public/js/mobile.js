$(function() {
  // copy-pasted from Game.coffee :(
  var socket;
  if (window.location.search.indexOf("local") !== -1) {
      socket = io.connect('http://localhost:8080', {secure: false})
  } else if (window.location.search.indexOf("dev") !== -1) {
      socket = io.connect('https://snap-backend-dev.herokuapp.com:443', {secure: true})
  } else {
      socket = io.connect('https://snapgame.herokuapp.com:443', {secure: true})
  }

  var global = {
    name: null,
    words: []
  };
  $("#nameInput").keypress(function(e) {
    if (e.which === 13) {
      global.name = $("#nameInput").val();
      socket.emit('new player', global.name);
      $("#nameForm").hide();
      $("#content").show();
      return false
    }
  });

  var Game = React.createClass({
    render: function() {
      return (
        <div id="game">
        <WordList />
        <WordInput />
        </div>
      );
    }
  });

  var WordList = React.createClass({
    getInitialState: function() {
      // what a hack
      global.WordList = this;
      return {
        words: [],
        scores: [{player: "--", score: 0},
          {player: "--", score: 0}]
      };
    },
    render: function() {
      return (
        <div>
        <table>
        <tr><td>{this.state.scores[0].player}{this.state.scores[0].me? " (you)" : ""}</td>
        <td>{this.state.scores[0].score}</td></tr>
        <tr><td>{this.state.scores[1].player}{this.state.scores[1].me? " (you)" : ""}</td>
        <td>{this.state.scores[1].score}</td></tr>
        </table>
        {
        this.state.words.slice(-4).map(function(word, i) {
          return <div key={word+i}>{word.word}{word.snapped ? ' - snap!' : ''}</div>;
        })
        }
        </div>
      );
    }
  });

  var WordInput = React.createClass({
    render: function() {
      return (
        <input id="wordInput" type="text" className="gameInput" placeholder="Enter word" disabled/>
      );
    }
  });

  React.render(
    <Game />,
    document.getElementById('content')
  );

  var updateWords = function() {
    global.WordList.setState({words: global.words});
  }

  $("#wordInput").keypress(function(e) {
    if (e.which === 13) {
      var word = $("#wordInput").val();
      $("#wordInput").val('');
      socket.emit('new word', word);
      global.words.push({word: word, snapped: false});
      updateWords();
      return false;
    }
  });

  socket.on('snap', function(snap) {
    for (var i = 0; i < global.words.length; i++) {
      if (global.words[i].word === snap.word) {
        global.words[i].snapped = true;
      }
    }
    updateWords();
  });

  socket.on('scores', function(scoreboard) {
    myScore = {player: global.name, score: scoreboard.myScore, me: true};
    topScore = scoreboard.scores[0];
    if (topScore.player == myScore.player &&
        topScore.name == myScore.name &&
          scoreboard.scores.length > 1) {
      topScore = scoreboard.scores[1];
    }
    topScore.me = false;
    // TODO(tchajed): handle case where you have the top score
    global.WordList.setState({scores: [topScore, myScore]});
  });

  socket.on('game started', function(game) {
    console.log("game started");
    $("#wordInput").removeAttr('disabled');
    $("#wordInput").focus();
  });

});
