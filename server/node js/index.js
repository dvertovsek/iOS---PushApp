var app = require('http').createServer()
var io = require('socket.io')(app);
var port = 8907;

app.listen(port, function() {

	console.log('Server listening at port %d', port);
});

io.on('connection', function (socket) {
	console.log("connected");
});