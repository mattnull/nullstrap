bcrypt = require('bcrypt')
 
exports.encrypt = (password, callback) ->
  bcrypt.genSalt 10, (err, salt) ->
    if err
    	callback(err)
    else
      bcrypt.hash password, salt, (err, hash) ->
        callback(err, hash)

exports.compare = (password, userPassword, callback) ->
  bcrypt.compare password, userPassword, (err, isPasswordMatch) ->
    if err 
    	callback(err)
    else 
    	callback(null, isPasswordMatch)