socket = io.connect()

# Application class that instantiates everything
window.BelayCapital = window.BelayCapital ? {}
window.BelayCapital.views = window.BelayCapital.views ? {}

jQuery ->
	
	class App

		constructor : () ->
			@gs = window.BelayCapital

			@gs.views.Settings = new window.BelayCapital.views.Settings

		# this unrenders all views
		unrender : ->
			views = @gs.views
			for i of views
				views[i].unrender()

		attachEvents : () ->

			# DOM
			$('#signup-form').submit (e) ->
				
				form = $(this)
				data = form.serialize()
				passwords = form.find('[type="password"]')
				err = $('#signup-error')
			
				if passwords.eq(0).val() isnt passwords.eq(1).val()
					err.html('Passwords don\'t match!')
					e.preventDefault()
				else
					$(this).submit()


			# Sockets
			socket.on 'hello', (data) ->
				console.log(data)


		registerPartials : ->
			for i of Handlebars.templates			
				key = i.split('-')[0]
				if key is 'partial'
					Handlebars.registerPartial(i, Handlebars.templates[i])

	window.BelayCapital.App = new App()
	window.BelayCapital.App.registerPartials()
	window.BelayCapital.App.attachEvents()
	Backbone.history.start()



