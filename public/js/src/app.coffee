socket = io.connect()

# Application class that instantiates everything
window.MyApp = window.MyApp ? {}
window.MyApp.views = window.MyApp.views ? {}

jQuery ->
	
	class App

		constructor : () ->
			@gs = window.MyApp

			@gs.views.Settings = new window.MyApp.views.Settings

		# this unrenders all views
		unrender : ->
			views = @gs.views
			for i of views
				views[i].unrender()

		attachEvents : () ->

			# Sockets
			socket.on 'hello', (data) ->
				console.log(data)


		registerPartials : ->
			for i of Handlebars.templates			
				key = i.split('-')[0]
				if key is 'partial'
					Handlebars.registerPartial(i, Handlebars.templates[i])

	window.MyApp.App = new App()
	window.MyApp.App.registerPartials()
	window.MyApp.App.attachEvents()
	Backbone.history.start()



