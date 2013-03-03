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
  run 'coffee', '-o', 'lib/', '-wc', 'src/'
  run 'stylus','-o', 'public/css', '-w', 'public/css/src'
  run 'supervisor', ['server.js']