/* App cache module */

'use strict';

module.exports = function (Module, App, Backbone) {

  var $ = Backbone.$;
  var appCache = window.applicationCache;

  $(appCache).on('updateready', function () {
    appCache.swapCache();
  });

  appCache.update();

};
