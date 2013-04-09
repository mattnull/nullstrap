development = 
	env : global.process.env.NODE_ENV || 'development',
	baseURI : 'http://localhost:3000',
	dbURI : 'mongodb://localhost/'

env = development

if global.process.env.NODE_ENV is 'production'
	env = production
else if global.process.env.NODE_ENV is 'staging'
	env = staging


module.exports = env