#Passport Configuration

mongoose = require 'mongoose'
Account = mongoose.model('Account')
passwords = require '../modules/passwords'
LocalStrategy = require('passport-local').Strategy

module.exports = (passport, config) ->
	
	passport.serializeUser (user, done) ->
	  done(null, user)

	passport.deserializeUser (obj, done) ->
	  done(null, obj)

	# Local
	passport.use new LocalStrategy (email, pass, done) =>
		
		Account.findOne {'users.email' : email}, {'users.$' : 1}, (error, account) ->

			if not error and account

				passwords.compare pass, account.users[0].password, (err, isMatch) =>
					if err
						done(err)
						return

					if not isMatch
						done(false, false, {message : 'Incorrect e-mail / password combination.'})
						return
						
					# remove password from session
					account.users[0].password = false

					done(null, account.users[0])
			else
				done()

