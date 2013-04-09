#Passport Configuration

mongoose = require 'mongoose'
passwords = require '../modules/passwords'
LocalStrategy = require('passport-local').Strategy
FacebookStrategy = require('passport-facebook').Strategy

module.exports = (passport, config) ->
	
	passport.serializeUser (user, done) ->
	  done(null, user)

	passport.deserializeUser (obj, done) ->
	  done(null, obj)

	# Facebook
	# passport.use new FacebookStrategy
	# 	clientID: config.fbAppID
	# 	clientSecret: config.fbSecret
	# 	callbackURL: config.baseURI + '/auth/facebook/callback'
	# , (accessToken, refreshToken, profile, done) ->
	# 	process.nextTick ->
	# 		done null, profile

	# Local
	passport.use new LocalStrategy (email, pass, done) ->