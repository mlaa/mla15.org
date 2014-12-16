'use strict';

var jQuery = require('jquery');
var underscore = require('underscore');
var Backbone = require('backbone');
var Templates = require('../build/src/compiled-templates.js');
var attachFastClick = require('fastclick');

// Side-shim jQuery and Underscore before requiring Marionette.
Backbone.$ = jQuery;
Backbone._ = underscore;

require('backbone.marionette');

// Attach FastClick.
attachFastClick(document.body);

// Create the application.
var App = new Backbone.Marionette.Application();

// Make templates available via the App object.
App.Templates = Templates;

// Add regions.
App.addRegions({
  Content: '#content',
  Actions: '#actions',
  Notice: '#notice'
});

// Load modules.
App.module('Data', require('./modules/data/main.js'));
App.module('Error', require('./modules/error/main.js'));
App.module('Filter', require('./modules/filter/main.js'));
App.module('Info', require('./modules/info/main.js'));
App.module('Links', require('./modules/links/main.js'));
App.module('Menus', require('./modules/menus/main.js'));
App.module('People', require('./modules/people/main.js'));
App.module('Program', require('./modules/program/main.js'));
App.module('Search', require('./modules/search/main.js'));
App.module('Updated', require('./modules/updated/main.js'));

// Start the history listener.
App.on('start', function () {
  Backbone.history.start({pushState: true});
});

// Start the application.
App.start();
