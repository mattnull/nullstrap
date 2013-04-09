# Settings

window.BelayCapital = window.BelayCapital ? {}
window.BelayCapital.views = window.BelayCapital.views ? {}

class Account extends Backbone.Model

	defaults :
		name : ''

	urlRoot : '/api/account'

class Settings extends Backbone.Collection
	
	model : Account


#parent settings view
class SettingsView extends Backbone.View

	el : '#settings'

	template : Handlebars.templates['settings']
	
	# events :

	initialize : (router) ->
		_.bindAll @
		@collection = new Settings
		@collection.bind 'add', @appendBoard
		@$el = $(@el)	
		
	render : ->
		@$el.html(@template({}))
		$('.main-navigation').find('.icon-gs-settings').parent().addClass('selected')
		$(@el).addClass('show')

	unrender : ->
		@$el.html('')
		$('.main-navigation').find('.icon-gs-settings').parent().removeClass('selected')
		$(@el).removeClass('show')



window.BelayCapital.views.Settings = SettingsView
