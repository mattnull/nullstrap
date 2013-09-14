fs = require 'fs'
{print} = require 'sys'
async = require 'async'
{log, error} = console; print = log
{spawn, exec} = require 'child_process'

run = (name, command, cb) ->
  cb = cb ? () ->
  proc = spawn(name, command.split(' '))
  proc.stdout.on('data', (buffer) -> print buffer if buffer = buffer.toString().trim())
  proc.stderr.on('data', (buffer) -> error buffer if buffer = buffer.toString().trim())
  proc.on 'exit', (status) ->
    process.exit(1) if status isnt 0
    cb()

task 'system', 'Install system dependencies ', () ->

  # install Dependencies (Run in sudo)
  async.series [
    (cb) -> 
      run 'npm', 'install -g bower', cb
    ,
    (cb) -> 
      run 'npm', 'install -g banshee', cb
    ,
    (cb) ->  
      run 'npm', 'install -g stylus', cb
    ,
    (cb) -> 
      run 'npm', 'install -g handlebars', cb
    ,
    (cb) -> 
      run 'npm', 'install -g uglify-js', cb
  ]

task 'install', 'Install dependancies ', () ->

  async.series [
      (cb) -> 
        run 'npm', 'install', cb
      ,
      (cb) -> 
        run 'bower', 'install', cb
  ]

task 'dev', 'Watch src/ for changes, compile, then output to lib/ ', () ->

  # combine vendor includes
  run 'banshee','public/js/_includes.js:public/js/vendor.js'

  # combine css includes
  run 'banshee','public/css/_includes.css:public/css/vendor.css'

  # stylus
  run 'stylus','-o public/css/lib -w public/css/src'

  run 'coffee', '--output lib --watch --compile src'
  run 'coffee', '--output public/js/lib --watch --compile public/js/src'
  # run 'coffee', '--join public/js/build.js --watch --compile public/js/src'

  run 'coffee', '--join public/js/build.js --compile public/js/src/'

  # pre-compile client-side templates
  templatesDir = 'public/js/templates/src'
  compileHandlebars = (template) ->
    # pre-compile client-side templates
    run 'handlebars', templatesDir + ' -f public/js/templates/templates.js'

   # watch client side templates
  templates = fs.readdirSync templatesDir
  for i in [0...templates.length]
    template = templatesDir + '/' + templates[i]
    do (template) ->
      fs.watch template, (curr, prev) ->
        compileHandlebars()

  compileHandlebars()

  run 'supervisor', 'server.js'

task 'build', 'Compress and combine javascript and CSS for production', () ->
  
  # compress and combine javascript
  run 'banshee', '-c public/js/lib:public/js/build.js'

  # compress and combine css
  run 'banshee', '-c public/css/lib:public/css/build.css'

  # compress and combine vendor javascript
  run 'banshee', '-c public/js/_includes.js:public/js/vendor.js'

  # compress and combine vendor css
  run 'banshee', '-c public/css/_includes.css:public/css/vendor.css'
  
