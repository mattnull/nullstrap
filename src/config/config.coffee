config = 
	production : 
		env : 'production',
		baseURI : 'http://mysite.com'
	,
	staging : 
		env : 'staging',
		baseURI : 'http://mystagingsite.com'
	,

	development :
		env : global.process.env.NODE_ENV || 'development',
		baseURI : 'http://localhost:3000'

module.exports = if global.process.env.NODE_ENV then config[global.process.env.NODE_ENV] else config.development
