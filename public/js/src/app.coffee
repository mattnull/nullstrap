socket = io.connect()
socket.on 'hello', (data) ->
	console.log(data)