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
		env : 'development',
		baseURI : 'http://localhost:3000',
		dbURI : 'mongodb://localhost'

module.exports = if global.process.env.NODE_ENV then config[global.process.env.NODE_ENV] else config.development
