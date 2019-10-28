const express = require('express')
const bodyParser = require('body-parser');
const path = require('path');
const http = require('http');

const port = 3000
const app = express()

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname + '/index.html'));
});


app.get('/name', function(req, res) {
    var options = {
  	host: "namegen",
	port: 5000,
	path: '/name',
	method: 'GET'
    };

    http.request(options, function(response) {
 	response.on('data', function (data) {
	   res.send(data);
      });
    }).end();
});


app.listen(port, () => console.log(`NameWeb started at port ${port}!`))
