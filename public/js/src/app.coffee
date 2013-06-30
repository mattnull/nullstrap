
# Application class that instantiates everything
window.Namespace = window.Namespace ? {}
window.Namespace.views = window.Namespace.views ? {}

jQuery ->
	
	class App

		constructor : () ->

		attachEvents : () ->

		registerPartials : ->
			for i of Handlebars.templates			
				key = i.split('-')[0]
				if key is 'partial'
					Handlebars.registerPartial(i, Handlebars.templates[i])

	window.Namespace.App = new App()
	window.Namespace.App.registerPartials()
	window.Namespace.App.attachEvents()
	Backbone.history.start()



