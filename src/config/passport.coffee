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
	passport.use new LocalStrategy (email, pass, done) ->
		
		Account.findOne {email : email}, (error, account) ->
			if not error and account

				passwords.compare pass, account.password, (isMatch) ->

					if not isMatch
						done(false, false, {message : 'Incorrect e-mail / password combination.'})
						return
						
					# remove password from session
					account.password = false

					done(null, account)
			else
				done(true)

