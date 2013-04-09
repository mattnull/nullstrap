# Router

window.BelayCapital = window.BelayCapital ? {}

class Router extends Backbone.Router 
	
	routes :
		"account" : "account"
		"" : "account"
		"_=_" : "account"

	account : () ->
		window.BelayCapital.App.unrender()
		window.BelayCapital.views.Settings.render()

window.BelayCapital.router = new Router