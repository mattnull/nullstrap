# Index controller

mongoose = require 'mongoose'
User = mongoose.model('User')

module.exports.index = (req, res) ->
	res.render 'index'

