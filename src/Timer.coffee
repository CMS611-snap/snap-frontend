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
    stepSecond = () =>
      @seconds++
      if @seconds >= 60
        @seconds = @seconds % 60
        @minutes++
      $(@id).html(timeToString(@seconds, @minutes, @hours))

    @interval = setInterval(stepSecond, 1000)

  stop: () ->
    clearInterval(@interval)

module.exports = Timer
