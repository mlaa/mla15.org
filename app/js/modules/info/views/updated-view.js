/* Update information view */

'use strict';

module.exports = function (Module, App, Backbone) {

  Module.Views = Module.Views || {};

  Module.Views.Updated = Backbone.Marionette.ItemView.extend({
    tagName: 'p',
    template: App.Templates['app/js/modules/info/templates/updated.tmpl']
  });

};
