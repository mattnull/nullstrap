fs = require 'fs'
{print} = require 'sys'
{log, error} = console; print = log
{spawn, exec} = require 'child_process'

run = (name, args...) ->
  proc = spawn(name, args)
  proc.stdout.on('data', (buffer) -> print buffer if buffer = buffer.toString().trim())
  proc.stderr.on('data', (buffer) -> error buffer if buffer = buffer.toString().trim())
  proc.on('exit', (status) -> process.exit(1) if status isnt 0)

task 'dev', 'Watch src/ for changes, compile, then output to lib/ ', (options) ->

  #server side coffeescript files
  run 'coffee', '-o', 'lib/', '-wc', 'src/'

  #client side coffeescript files
  run 'coffee', '-o', 'public/js/lib', '-wc', 'public/js/src/'

  #stylus
  run 'stylus','-o', 'public/css/lib', '-w', 'public/css/src'

  #run server.js using Supervisor
  run 'supervisor', ['server.js']

task 'build', 'Compress and combine javascript and CSS for production', () ->
  
  #compress and combine javascript
  run 'banshee', '-c', 'public/js/lib:public/js/build.js'

  #compress and combine vendor javascript
  run 'banshee', '-c', 'public/js/vendor:public/js/vendor.js'

  #compress and combine css
  run 'banshee', '-c','public/css/lib:public/css/build.css'

  #compress and combine vendor css
  run 'banshee', '-c', 'public/css/vendor:public/css/vendor.css'

