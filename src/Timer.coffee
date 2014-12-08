class Timer
  constructor: (@id, @elapsed) ->
    @seconds = 0
    @minutes = 0
    @hours = 0
    @startTime = null
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
    hoursString = ""
    minutesString = ""
    secondsString = ""
    if hours < 10
      hoursString = "0" + hours
    else
      hoursString = hours
    if minutes < 10
      minutesString = "0" + minutes
    else
      minutesString = minutes
    if seconds < 10
      secondsString = "0" + seconds
    else
      secondsString = seconds
    timeString = ""
    if hours > 0
      timeString += hoursString + ":"
    timeString += "#{minutesString}:#{secondsString}"
    return timeString

  startInterval: () ->
    @startTime = Date.now()
    stepSecond = () =>
      totalSeconds = Math.floor((Date.now() - @startTime) / 1000) + @elapsed
      time = parseSeconds(totalSeconds)
      @hours = time.hours
      @minutes = time.minutes
      @seconds = time.seconds
      $(@id).html(timeToString(@seconds, @minutes, @hours))

    @interval = setInterval(stepSecond, 500)

  stop: () ->
    clearInterval(@interval)

module.exports = Timer
