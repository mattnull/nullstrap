crypto = require('crypto')
 
exports.encrypt = (password) ->
  return crypto.createHash('sha512').update(password).digest('hex')

exports.compare = (password, userPassword, cb) ->
  if @encrypt(password) is userPassword
    cb(true)
  else
    cb(false)