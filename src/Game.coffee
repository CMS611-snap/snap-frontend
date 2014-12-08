Viz    = require './Viz'
Player = require './Player'
Timer  = require './Timer'

class Game
  constructor: ->
    @players = {}
    @player  = null
    @timer = null
    @maxWords = null
    @maxScore = null
    @topic   = ''
    width  = $('#col2').width()
    height = $('#col2').height()
    @viz = new Viz(width, height)
    @viz.two.appendTo $("#viz").get(0)

    $('#nameForm').submit (evt) =>
      evt.preventDefault()
      @joinGame $('#name').val()

    $('#wordForm').submit (evt) =>
      evt.preventDefault()
      word = $('#word').val()
      if word == ""
        return
      @sendWord word, (snap) =>
        @player.addWord word
        if @maxWords and @player.word_count >= @maxWords
          $('#word').prop('disabled', true)
          $('#word').attr('placeholder', "Already submitted #{@player.word_count} words/phrases")
        if snap?
          @snap(snap)
        else
          $('#wordList').append('<span>'+word.toLowerCase()+'</span><br>')
        $('#word').val('')
        $("#wordList").animate({ scrollTop: $("#wordList").prop("scrollHeight")}, 100)
        $('#word').removeClass('usedWord')
      , (error) =>
        if error == "duplicate"
          $('#word').addClass('usedWord')
        else
          console.log "error submitting #{word}: #{error}"
        $("#wordWrapper").effect('shake', {distance: 10})

    @socket = @setupSocket()
    @socket.on 'new topic', (data) =>
      @topic = data
      $('#info').fadeOut 400, =>
          $('#info').html('<strong>Topic set to:</strong> ' + @topic).fadeIn(500)
      $('#wordListInfo').hide()
      $('#wordListInfo').html('<strong>Your words will appear here:</strong>')
      $('#wordListInfo').fadeIn(500)


  joinGame: (playerName) ->
    # set the main player
    @player = new Player(@viz.two, playerName, null, "#00FF00")

    # update the display
    $('#info').fadeOut 400, ->
      $('#info').html('<strong> Hi '+playerName+',</strong> important information will appear here.').fadeIn(500)
    $( "#nameForm" ).fadeOut 400, ->
        $('#gameState').css('visibility', 'visible')
        $('#gameState').hide()
        $('#gameState').fadeIn(500)

    @socket.emit 'new player', playerName

    @socket.on 'Player ID', (identifier) => 
      @player.id = identifier.uuid

    @socket.on 'userJoin', (data)=>
      player = data.identifier
      if player.uuid isnt @player.id
        @players[player.uuid] = new Player(@viz.two,player.name,player.uuid)

    @socket.on 'game started', (data) =>
      #start client timer here
      console.log @player.id
      console.log data.players
      if data.elapsed
        $("#timeContainer").html('<p class="text-left">TIME: <span id="time"></span></p>')
        @timer = new Timer('#time', parseInt(data.elapsed/1000))
        @timer.startInterval()
      @maxWords = data.maxWords
      @maxScore = data.maxScore
      @topic = data.topic

      # update the display
      $('#word').removeAttr('disabled')
      $('#word').attr('placeholder', 'Enter a word or phrase and press enter')
      $('#info').fadeOut 200, () =>
        startedMessage = "<strong>Game has started!</strong> Go go go!"
        topicMessage = "Topic is #{@topic}."
        if @maxWords
          endInfo = "Limited to #{@maxWords} words or phrases."
        else
          endInfo = ""
        $('#info').html("#{startedMessage} #{topicMessage} #{endInfo}").fadeIn(300)

      # create player objects and their dots
      for player in data.players
        console.log player.uuid
        if player.uuid isnt @player.id
          @players[player.uuid] = new Player(@viz.two, player.name, player.uuid)

    @socket.on 'game over', (data) =>
      winners = data.winners.map((p) -> p.name).join(', ')
      for id, player of @players
        player.reset()

      @player.reset()

      @timer?.stop()

      $('#info').fadeOut 200, =>
          $('#info').html('<strong> Game Over! </strong> Congratulations to winners: '+ "<marquee>#{winners}</marquee>").fadeIn(300)
      $('#word').prop('disabled', true)
      $('#word').attr('placeholder', 'Please wait for the game to start')

    @socket.on 'snap', (data) =>
      @snap(data)

    @socket.on 'scores', (data) =>
      maxScore = Math.max.apply(Math, data.scores.map((p)->p.score))
      for s in data.scores
        if s.player.uuid isnt @player.id
          y = (1-s.score/Math.max(1,maxScore)) * @viz.two.height
          @players[s.player.uuid].move(Math.max(10,Math.min(@viz.two.height-10,y)))
        else
          y = (1-@player.score/Math.max(1,maxScore)) * @viz.two.height
          @player.move(Math.max(10,Math.min(@viz.two.height-10,y)))
      for snap in data.snaps
        for p1 in snap.players
          player1 = @players[p1.uuid]
          if not player1?
            continue
          for p2 in snap.players when p1.uuid != p2.uuid
            player2 = @players[p2.uuid]
            player2?.snapSubtle(player1)

#      # update a player's score
#      @player.addPoints data.d_score
#      $('#score').html(@player.score)
#
#      # update the word list
#      $('#wordList').html()
#      $('#wordList').append('<span class="snappedWord">'+data.word+' ('+snappedPlayers+')</span><br>')

    @socket.on 'disconnect', () =>
      location.reload()

  snap: (data) ->
    console.log data
    @player.addPoints data.d_score
    snappedPlayers = data.player.filter (p) => p.name isnt @player.name
    for player in snappedPlayers
      @player.snap(@players[player.uuid])
    playerNames = snappedPlayers.map (p) -> p.name

    @player.snapAnim data.word, playerNames

    # Play a random snap sound
    sound = "#snap" + Math.floor(Math.random() * 12)
    $(sound).trigger("play")

    $('#wordList').append("<span class=\"snappedWord\"> #{data.word} (#{playerNames.join(', ')})</span><br />")
    $('#score').html(@player.score)


  # success is a callback that is passed a snap event (or null)
  # error is a callback that is passed an error string
  sendWord: (word, success, error) ->
    @socket.emit 'new word', word, (resp) ->
      if resp.success
        success(resp.snap)
      else
        error(resp.error)

  setupSocket: ->
    if window.location.search.indexOf("local") != -1
        return io.connect('http://localhost:8080', {secure: false})
      else if window.location.search.indexOf("dev") != -1
        return io.connect('https://snap-backend-dev.herokuapp.com:443', {secure: true})
      else
        return io.connect('https://snapgame.herokuapp.com:443', {secure: true})

module.exports = Game
