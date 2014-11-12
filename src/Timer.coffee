class Timer
  constructor: (@game) ->
    @seconds = 0
    @minutes = 0
    @hours = 0
    @interval = undefined
    @timerText = undefined

  timeToString = (seconds, minutes, hours) ->
    timeString = ""
    if (hours != undefined)
      hoursString = ""
      if (hours < 10)
        hoursString += "0" + hours
      else
        hoursString += hours
      hoursString += ":"
      timeString += hoursString
    if (minutes != undefined)
      minutesString = ""
      if (minutes < 10)
        minutesString += "0" + minutes
      else
        minutesString += minutes
      minutesString += ":"
      timeString += minutesString
    if (seconds != undefined)
      secondsString = ""
      if (seconds < 10)
        secondsString += "0" + seconds
      else
        secondsString += seconds
      timeString += secondsString

    timeString

  startInterval: () ->

    that = this
    stepSecond = () ->
      that.seconds++
      if (that.seconds >= 60) 
        that.seconds = 0
        that.minutes++
      if (!that.timerText)
        that.timerText = that.game.add.text(that.game.width - 100, that.game.height - 30, timeToString(that.seconds, that.minutes), {
          font: '20px Arial', 
          fill: '#ffffff'
        })
      else
        that.timerText.text = timeToString(that.seconds, that.minutes)

    setInterval(stepSecond, 1000)    

module.exports = Timer