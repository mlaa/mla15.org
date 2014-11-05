/* Session detail view */

module.exports = function (Module, App, Backbone) {

  var $ = Backbone.$;

  Module.Views = Module.Views || {};

  Module.Views.SessionDetail = Backbone.Marionette.ItemView.extend({

    tagName: 'div',
    className: 'session',
    template: App.Templates['app/js/modules/program/templates/session-detail.tmpl'],

    serializeData: function () {
      return $.extend(
        this.model.toJSON(),
        this.model.getSessionProperties()
      );
    },

    events: {
      'click .text-head': 'loadParentMenu'
    },

    loadParentMenu: function (e) {
      e.preventDefault();
      App.vent.trigger('menu:showParent', '');
    }

  });

};
