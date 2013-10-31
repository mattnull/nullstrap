
window.Namespace = window.Namespace ? {}
	
class App

	constructor : () ->

	attachEvents : () ->

	registerPartials : ->
		for i of Handlebars.templates			
			key = i.split('-')[0]
			if key is 'partial'
				Handlebars.registerPartial(i, Handlebars.templates[i])

$ ->
	window.Namespace.App = new App()
	window.Namespace.App.registerPartials()
	window.Namespace.App.attachEvents()



