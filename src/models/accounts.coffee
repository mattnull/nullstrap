# Accounts Model

mongoose = require 'mongoose'
Schema = mongoose.Schema

#Account Collection
accounts = new Schema
	name : String,
	company : String,
	email : {type : String, required : true, unique : true},
	password : {type : String, required : true},
	
accounts.pre 'save', (next) ->
	next()

mongoose.model 'Account', accounts