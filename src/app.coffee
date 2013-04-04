express = require('express')
app = express()
server = require('http').createServer(app)
io = require('socket.io').listen(server)
passport = require 'passport'
RedisStore = require('connect-redis')(express)
hbsPrecompiler = require 'handlebars-precompiler'

# Configuration
app.configure () ->
  app.set('views', __dirname + '/../views')
  app.set('view engine', 'jade')
  app.set('view options', {layout: false})
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use('/public', express.static(__dirname + '/../public'))
  app.use('/components', express.static(__dirname + '/../components'))
  app.use(express.methodOverride())  
  app.use(express.cookieParser())
  app.use(express.bodyParser())

  # Heroku redistogo connection
  if process.env.REDISTOGO_URL
    rtg   = require('url').parse process.env.REDISTOGO_URL
    redis = require('redis').createClient rtg.port, rtg.hostname
    redis.auth rtg.auth.split(':')[1] # auth 1st part is username and 2nd is password separated by ":"
    app.use(express.session
      secret: process.env.REDIS_SECRET or "super secret string"
      maxAge : new Date Date.now() + 7200000 # 2h Session lifetime
      store: new RedisStore {client: redis}
    )
  else # Localhost
    app.use(express.session({secret : 'mysupersecret'}))
  
  app.use(passport.initialize())
  app.use(passport.session())
  app.use(app.router)

  if not process.env.NODE_ENV
    hbsPrecompiler.watchDir(
      __dirname + "/../public/templates/src",
      __dirname + "/../public/templates/templates.js",
      ['handlebars']
    )

# Routes
app.get '/', (req, res) ->
	res.render('index')

# Socket Events
io.sockets.on 'connection', (socket) ->
	socket.emit 'hello', {data : 'Hi!'}

port = process.env.PORT or 3000
server.listen port, () -> 
	console.log "Server running on port " + port
