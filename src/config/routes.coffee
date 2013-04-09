
# Routes

module.exports = (app, passport) ->

	#Index
	index = require '../controllers/index'
	app.get '/', index.index