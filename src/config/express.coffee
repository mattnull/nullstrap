express = require('express')
RedisStore = require('connect-redis')(express)
module.exports = (app , passport) ->

  app.configure () ->
    app.set('views', __dirname + '/../../views')
    app.set('view engine', 'jade')
    app.set('view options', {layout: false})
    app.use(express.bodyParser())
    app.use(express.cookieParser())
    app.use(express.methodOverride())
    app.use(express.compress());
    app.use('/public', express.static(__dirname + '/../../public', {maxAge : 86400000}))
    app.use('/components', express.static(__dirname + '/../../bower_components', {maxAge : 86400000}))
    app.use(express.favicon())

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
      # redis = require('redis').createClient 6379, 'localhost'
      # app.use(express.session
      #   secret : 'nullstrapy'
      #   maxAge : new Date Date.now() + 72000 # 2 hours
      #   store: new RedisStore {client: redis, ttl : 7200}
      # )

      app.use(express.cookieParser());
      app.use(express.cookieSession({secret : "kittens!!!1111"}));    

    
    app.use(passport.initialize())
    app.use(passport.session())
    app.use(app.router)

  app.ensureAuthenticated = (req, res, next) ->
    return next() if req.isAuthenticated()
    res.redirect "/login"