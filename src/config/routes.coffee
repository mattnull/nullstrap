
# Routes

module.exports = (app, passport) ->

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


