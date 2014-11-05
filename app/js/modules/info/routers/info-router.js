/* Info router */

module.exports = function (Module, App, Backbone) {
  return Backbone.Marionette.AppRouter.extend({
    initialize: function (options) {
      this.route(/^info\/(.+)$/, options.controller.showInfo);
    }
  });
};
