express = require('express')
RedisStore = require('connect-redis')(express)
hbsPrecompiler = require 'handlebars-precompiler'

module.exports = (app , passport) ->
  
  app.configure () ->
    app.set('views', __dirname + '/../../views')
    app.set('view engine', 'jade')
    app.set('view options', {layout: false})
    app.use(express.bodyParser())
    app.use(express.cookieParser())
    app.use(express.methodOverride())
    app.use('/public', express.static(__dirname + '/../../public'))
    app.use('/components', express.static(__dirname + '/../../components'))

    app.use(express.favicon(__dirname+'/../../favicon.ico'));

    app.use (err, req, res, next) ->
      console.error(err.stack)
      res.send(500, 'An error has occured.')

    # Heroku redistogo connection
    if process.env.REDISTOGO_URL
      rtg   = require('url').parse process.env.REDISTOGO_URL
      redis = require('redis').createClient rtg.port, rtg.hostname
      redis.auth rtg.auth.split(':')[1] # auth 1st part is username and 2nd is password separated by ":"
      app.use(express.session
        secret: process.env.REDIS_SECRET or "super secret string"
        maxAge : new Date Date.now() + 7200000 # 2h Session lifetime
        store: new RedisStore {client: redis, ttl : 7200}
      )
    else # Localhost
      redis = require('redis').createClient 6379, 'localhost'
      app.use(express.session
        secret : 'meowmeowmeow'
        maxAge : new Date Date.now() + 60000 # 1 minute
        store: new RedisStore {client: redis, ttl : 60}
      )
    
    app.use(passport.initialize())
    app.use(passport.session())
    app.use(app.router)

    if not process.env.NODE_ENV
      hbsPrecompiler.watchDir(
        __dirname + "/../public/templates/src",
        __dirname + "/../public/templates/templates.js",
        ['handlebars']
      )

  app.ensureAuthenticated = (req, res, next) ->
    return next() if req.isAuthenticated()
    res.redirect "/login"