#Auth controller

module.exports.login = (req, res) ->
	if not req.isAuthenticated()
		res.render 'login'
	else
		res.redirect '/'

module.exports.logout = (req, res) ->
	req.logout()
	res.redirect '/'

module.exports.auth = (req, res) ->
	res.redirect '/'



	

	
