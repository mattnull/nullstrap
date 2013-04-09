# Users Model

mongoose = require 'mongoose'

Schema = mongoose.Schema

#User Collection
users = new Schema
	name : String
	
users.pre 'save', (next) ->
	next()

mongoose.model 'User', users