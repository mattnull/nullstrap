fs = require 'fs'
flour = require 'flour'
{print} = require 'sys'
{log, error} = console; print = log
{spawn, exec} = require 'child_process'

run = (name, args...) ->
  proc = spawn(name, args)
  proc.stdout.on('data', (buffer) -> print buffer if buffer = buffer.toString().trim())
  proc.stderr.on('data', (buffer) -> error buffer if buffer = buffer.toString().trim())
  proc.on('exit', (status) -> process.exit(1) if status isnt 0)

task 'system', 'Install system dependancies ', () ->

  # install Dependencies (Run in sudo)

  run 'npm', 'install', '-g', 'bower'
  run 'npm', 'install', '-g', 'express'
  run 'npm', 'install', '-g', 'jade'
  run 'npm', 'install', '-g', 'supervisor'
  run 'npm', 'install', '-g', 'banshee'
  run 'npm', 'install', '-g', 'stylus'

task 'install', 'Install dependancies ', () ->

  run 'npm', 'install'
  run 'bower', 'install'

task 'dev', 'Watch src/ for changes, compile, then output to lib/ ', () ->
  
  flour.minifiers.disable 'js'
  flour.silent true
  
  watch 'public/js/lib', -> invoke 'combine'  

  # watch js includes
  run 'banshee','public/js/_includes.js:public/js/vendor.js'

  # watch css includes
  run 'banshee', 'public/css/_includes.css:public/css/vendor.css'

  # server side coffeescript files
  run 'coffee', '-o', 'lib/', '-wc', 'src/'

  # client side coffeescript files

  run 'coffee', '-o', 'public/js/lib/', '-wc', 'public/js/src/'

  # stylus
  run 'stylus','-o', 'public/css/lib', '-w', 'public/css/src'

  # run server.js using Supervisor
  run 'supervisor', ['server.js']

task 'combine', 'Automatically combine files for dev', () ->
  
  paths =
    models : 'public/js/lib/models'
    views : 'public/js/lib/views'
  
  for i of paths
    d = []
    files = fs.readdirSync paths[i]
    for j in [0...files.length]
      d.push paths[i] + '/' + files[j]

    bundle d, 'public/js/lib/' + i + '.js'


task 'build', 'Compress and combine javascript and CSS for production', () ->
  
  # compress and combine javascript
  run 'banshee', '-c', 'public/js/lib:public/js/build.js'

  # compress and combine css
  run 'banshee', '-c','public/css/lib:public/css/build.css'

  # compress and combine vendor javascript
  run 'banshee', '-c', 'public/js/_includes.js:public/js/vendor.js'

  # compress and combine vendor css
  run 'banshee', '-c', 'public/css/_includes.css:public/css/vendor.css'

