gulp       = require 'gulp'
watch      = require 'gulp-watch'
livereload = require 'gulp-livereload'
browserify = require 'browserify'
nodemon    = require 'gulp-nodemon'
source     = require 'vinyl-source-stream'
jade       = require 'gulp-jade'

gulp.task 'coffee', ->
  browserify
    entries: ['./src/main.coffee']
    extensions: ['.coffee', '.js']
    debug: true
  .transform 'jadeify'
  .transform 'coffeeify'
  .bundle()
  .pipe source 'main.js'
  .pipe gulp.dest 'public/js'

gulp.task 'watch', ->
  gulp.watch './src/*.coffee', ['coffee']

gulp.task 'develop', ->
  livereload.listen()
  nodemon {script: 'app.js', ex: 'js html'}
    .on 'start', ['watch']
    .on 'restart', ->
      console.log 'restart server'

gulp.task 'default', ['coffee', 'develop']

gulp.task('heroku:development', ['coffee'])
gulp.task('heroku:production', ['coffee'])
