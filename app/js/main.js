/* Main */

// Start the history listener.
MLA14.on('start', function() {
  Backbone.history.start({pushState: true});
});

// Start application.
MLA14.start();
