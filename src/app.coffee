fs = require 'fs'
express = require('express')
app = express()
server = require('http').createServer(app)
io = require('socket.io').listen(server)

# Configuration
app.configure () ->
  app.set('views', __dirname + '/../views')
  app.set('view engine', 'jade')
  app.set('view options', {layout: false})
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(app.router)
  app.use(express.static(__dirname + '/../public'))

# Routes
app.get '/', (req, res) ->
	res.sendfile './views/index.html'

# Socket.IO
io.sockets.on 'connection', (socket) ->
	socket.emit 'hello', {data : 'Hi!'}

port = process.env.PORT or 3000
server.listen port, () -> 
	console.log "Listening on port " + port
