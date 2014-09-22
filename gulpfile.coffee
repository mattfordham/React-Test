#--------------------------------------------------------
# Requires
#--------------------------------------------------------

gulp         = require "gulp" 
concat       = require "gulp-concat" 
stylus       = require "gulp-stylus" 
autoprefixer = require "gulp-autoprefixer" 
livereload   = require "gulp-livereload" 
browserify   = require "gulp-browserify" 
rename       = require "gulp-rename" 
bowerFiles   = require "gulp-bower-files" 
uglify       = require "gulp-uglify"
connect      = require "gulp-connect"


#--------------------------------------------------------
# Variables
#--------------------------------------------------------

src  = "src"
dist = "public"


#--------------------------------------------------------
# CSS
#--------------------------------------------------------

gulp.task "stylus", ->
  gulp.src "#{src}/css/*.styl"
    .pipe stylus()
    .pipe autoprefixer()
    .pipe gulp.dest("#{dist}/css")


# --------------------------------------------------------
# Connect to server
# --------------------------------------------------------


gulp.task "connect", ->
   connect.server
      host: null
      port: "3000"
      root: "#{dist}"


#--------------------------------------------------------
# JavaScript
#--------------------------------------------------------

gulp.task "coffee", ->
  gulp.src "#{src}/js/main.coffee", read: false
    .pipe browserify {transform: ["coffeeify"], extensions: [".coffee"]}
    .pipe rename("app.js")
    .pipe gulp.dest("#{dist}/js")


#--------------------------------------------------------
# Bower / Vendor Concatenation/Minification
#--------------------------------------------------------

gulp.task "bower", ->
  bowerFiles()
    .pipe concat("vendor.js")
    .pipe uglify()
    .pipe gulp.dest("#{dist}/js")


#--------------------------------------------------------
# Watch
#--------------------------------------------------------

gulp.task "watch", ->

  # CSS Compilation
  gulp.watch "#{src}/css/*.styl", ["stylus"]

  # JavaScript Complilation
  gulp.watch "#{src}/js/*.coffee", ["coffee"]
  
  # Vendor Concatenation/Minification with Bower
  gulp.watch "#{src}/vendor/**", ["bower"]

  # LiveReload
  server = livereload()
  gulp.watch(["#{dist}/**"]).on "change", (file) ->
    server.changed file.path


#--------------------------------------------------------
# Tasks
#--------------------------------------------------------

gulp.task "default", ["stylus", "coffee", "bower", "watch", "connect"]


