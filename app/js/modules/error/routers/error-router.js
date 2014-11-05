/* Error router */

module.exports = function (Module, App, Backbone) {
  return Backbone.Marionette.AppRouter.extend({
    appRoutes: {
      '*error': 'handleError'
    }
  });
};
