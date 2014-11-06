/* Update information view */

'use strict';

module.exports = function (Module, App, Backbone) {

  Module.Views = Module.Views || {};

  Module.Views.Updated = Backbone.Marionette.ItemView.extend({
    tagName: 'span',
    template: App.Templates['app/js/modules/menus/templates/updated.tmpl']
  });

};
