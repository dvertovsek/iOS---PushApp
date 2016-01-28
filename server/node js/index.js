var io = require('socket.io')(8907);

io.on('connection', function (socket) {
  socket.broadcast.emit('user connected');
});