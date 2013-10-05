#Users controller
passwords = require '../modules/passwords'
mongoose = require 'mongoose'
Account = mongoose.model('Account')

module.exports.createAccount = (req, res) ->
	body = req.body

	if not body.name or 
		not body.email or 
		not body.pass1 or 
		not body.pass2 or 
		body.pass1 isnt body.pass2
			res.send JSON.stringify({error : 'Please complete the form'})
			return

	user = {}
	user.name = body.name
	user.email = body.email

	user.password = passwords.encrypt body.pass1
	accountModel = new Account(user)
	accountModel.save (err) ->
		
		if err
			res.send JSON.stringify({error : 'An error occured. Please try again.'})
		else
			#login the user and redirect
			req.logIn accountModel, (err) =>

				if err 
					return next(err)

				res.redirect('/')

	

