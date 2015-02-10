//This could be a static file server right now, but versioning capabilites are likely to be required
var express = require('express'),
    server = express();

server.configure(function(){
    server.use('/ns',express.static(__dirname + 'ns'));
    server.use(express.static(__dirname + '/ns'));
});

server.listen(80);


