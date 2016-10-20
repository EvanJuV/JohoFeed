var express = require('express'),
    http = require('http'),
    util = require('util'),
    querystring = require('querystring');

// var router = express.Router();
// var mongoose = require('mongoose');

var app = express();
app.configure(function () {
    app.set('port', process.env.PORT || 3000);
    app.use(express.favicon());
    app.use(express.logger('dev'));
    app.use(express.bodyParser());
    app.use(express.methodOverrside());
    app.use(express.cookieParser(''));
    app.use()
});

// load mongoose package
var mongoose = require('mongoose');
// Use native Node promises
mongoose.Promise = global.Promise;
// connect to MongoDB
mongoose.connect('mongodb://localhost/johoFeedDB')
  .then(() =>  console.log('connection succesful'))
  .catch((err) => console.error(err));

var users = require('./routes/users');
app.use('/users', users);