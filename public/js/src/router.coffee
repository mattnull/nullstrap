# Router

window.MyApp = window.MyApp ? {}

class Router extends Backbone.Router 
	
	routes :
		"account" : "account"
		"" : "account"
		"_=_" : "account"

	account : () ->
		window.MyApp.App.unrender()
		window.MyApp.views.Settings.render()

window.MyApp.router = new Router