# Router

window.Namespace = window.Namespace ? {}

class Router extends Backbone.Router 
	
	routes :
		"account" : "account"
		"" : "account"
		"_=_" : "account"

	account : () ->
		window.Namespace.App.unrender()
		window.Namespace.views.Settings.render()

window.Namespace.router = new Router