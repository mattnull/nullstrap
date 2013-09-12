
# Routes

module.exports = (app, passport) ->

	routeMiddleware = (req, res, next) ->
		#Always pass user object and environment variable to views
		res.locals.user = req.user
		res.locals.ENV = global.process.env.NODE_ENV
		return next() if req.isAuthenticated()
		res.redirect "/login"
		next()
		
	#Index
	index = require '../controllers/index'
	app.get '/', index.index

	#Auth
	auth = require '../controllers/auth'
	app.get '/login', auth.login
	app.post '/auth', passport.authenticate('local', failureRedirect: '/login'), auth.auth
	app.get '/logout', auth.logout

	#Users
	users = require '../controllers/users'
	app.post '/createaccount', users.createAccount


