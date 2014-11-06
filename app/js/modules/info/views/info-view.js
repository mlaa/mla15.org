/* Info view */

'use strict';

module.exports = function (Module, App, Backbone) {

  Module.Views = Module.Views || {};

  Module.Views.Info = Backbone.Marionette.ItemView.extend({

    tagName: 'div',
    className: 'info',
    template: App.Templates['app/js/modules/info/templates/info.tmpl'],

    events: {
      'click .text-head': 'loadParentMenu'
    },

    loadParentMenu: function() {
      App.vent.trigger('menu:showParent', 'info');
    }

  });

};
