# Accounts Model

mongoose = require 'mongoose'
Schema = mongoose.Schema

#User Collection
users = new Schema
	name : String
	company : String
	email : {type : String, required : true, unique : true},
	password : {type : String, required : true},
	accountID : String

#Account Collection
accounts = new Schema
	name : String,
	company : String,
	email : {type : String, required : true},
	password : {type : String, required : true},
	devices : Array,
	users : [users]
	
accounts.pre 'save', (next) ->
	
	#create the default user when an account is created
	@users.push {
		name : @name,
		company : @company,
		email : @email,
		password : @password,
		accountID : @_id
	}

	next()

mongoose.model 'Account', accounts