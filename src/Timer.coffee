class Timer
  constructor: (@id, @elapsed) ->
    @seconds = 0
    @minutes = 0
    @hours = 0
    @interval = undefined

    if @elapsed
      time = parseSeconds(@elapsed)
      @seconds = time.seconds
      @minutes = time.minutes
      @hours = time.hours

  parseSeconds = (seconds) ->
    hours = Math.floor(seconds/3600)
    seconds -= hours*3600

    minutes = Math.floor(seconds/60)
    seconds -= minutes*60

    {hours: hours, minutes: minutes, seconds: seconds}

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
      $(that.id).html(timeToString(that.seconds, that.minutes, that.hours))

    @interval = setInterval(stepSecond, 1000)

  stop: () ->
    clearInterval(@interval)

module.exports = Timer
